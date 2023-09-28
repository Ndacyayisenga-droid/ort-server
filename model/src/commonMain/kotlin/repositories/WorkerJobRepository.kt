/*
 * Copyright (C) 2023 The ORT Project Authors (See <https://github.com/oss-review-toolkit/ort-server/blob/main/NOTICE>)
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * SPDX-License-Identifier: Apache-2.0
 * License-Filename: LICENSE
 */

package org.ossreviewtoolkit.server.model.repositories

import kotlinx.datetime.Instant

import org.ossreviewtoolkit.server.model.JobStatus
import org.ossreviewtoolkit.server.model.WorkerJob
import org.ossreviewtoolkit.server.model.util.OptionalValue
import org.ossreviewtoolkit.server.model.util.asPresent

/**
 * A common interface for repositories that manage worker jobs.
 *
 * This interface defines a number of methods that are needed for all concrete jobs. It allows dealing with jobs in a
 * generic way.
 */
interface WorkerJobRepository<T : WorkerJob> {
    /**
     * Get a job by [id]. Returns null if the job is not found.
     */
    fun get(id: Long): T?

    /**
     * Get the job for an [ORT run][ortRunId].
     */
    fun getForOrtRun(ortRunId: Long): T?

    /**
     * Update a job by [id] with the [present][OptionalValue.Present] values.
     */
    fun update(
        id: Long,
        startedAt: OptionalValue<Instant?> = OptionalValue.Absent,
        finishedAt: OptionalValue<Instant?> = OptionalValue.Absent,
        status: OptionalValue<JobStatus> = OptionalValue.Absent
    ): T

    /**
     * Mark a job by [id] as completed by updating the given [finishedAt] date and setting the given [status].
     */
    fun complete(id: Long, finishedAt: Instant, status: JobStatus): T {
        require(status in completedJobStates) {
            "complete can only be called with a JobStatus that mark the job as completed: $completedJobStates."
        }

        return update(
            id,
            finishedAt = finishedAt.asPresent(),
            status = status.asPresent()
        )
    }

    /**
     * Mark a job by [id] as completed if it is not yet in a completed state. This function works similar to
     * [complete], but first checks the [JobStatus] of the affected job. It can be used to complete jobs in a safe
     * way, in case multiple completion messages are received. If the update is possible, return the updated entity;
     * otherwise, return *null*.
     */
    fun tryComplete(id: Long, finishedAt: Instant, status: JobStatus): T? {
        val currentStatus = requireNotNull(get(id)?.status) {
            "${javaClass.simpleName}: Job '$id' not found."
        }

        return if (currentStatus !in completedJobStates) {
            complete(id, finishedAt, status)
        } else {
            null
        }
    }
}

/**
 * A set with the [JobStatus] values that indicate a completed job.
 */
private val completedJobStates = setOf(JobStatus.FINISHED, JobStatus.FAILED)
