/*
 * Copyright (C) 2024 The ORT Server Authors (See <https://github.com/eclipse-apoapsis/ort-server/blob/main/NOTICE>)
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

package org.eclipse.apoapsis.ortserver.services

import org.eclipse.apoapsis.ortserver.dao.dbQuery
import org.eclipse.apoapsis.ortserver.dao.tables.EvaluatorJobsTable
import org.eclipse.apoapsis.ortserver.dao.tables.runs.evaluator.EvaluatorRunsRuleViolationsTable
import org.eclipse.apoapsis.ortserver.dao.tables.runs.evaluator.EvaluatorRunsTable
import org.eclipse.apoapsis.ortserver.dao.tables.runs.evaluator.RuleViolationDao
import org.eclipse.apoapsis.ortserver.dao.tables.runs.evaluator.RuleViolationsTable
import org.eclipse.apoapsis.ortserver.dao.tables.runs.shared.IdentifierDao
import org.eclipse.apoapsis.ortserver.dao.tables.runs.shared.IdentifiersTable
import org.eclipse.apoapsis.ortserver.dao.utils.listCustomQuery
import org.eclipse.apoapsis.ortserver.model.RuleViolationWithIdentifier
import org.eclipse.apoapsis.ortserver.model.util.ListQueryParameters
import org.eclipse.apoapsis.ortserver.model.util.ListQueryResult

import org.jetbrains.exposed.sql.Database
import org.jetbrains.exposed.sql.ResultRow

/**
 * A service to interact with rule violations.
 */
class RuleViolationService(private val db: Database) {
    suspend fun listForOrtRunId(
        ortRunId: Long,
        parameters: ListQueryParameters = ListQueryParameters.DEFAULT
    ): ListQueryResult<RuleViolationWithIdentifier> = db.dbQuery {
        val ruleViolationQueryResult =
            RuleViolationDao.listCustomQuery(parameters, ResultRow::toRuleViolation) {
                val join = RuleViolationsTable innerJoin
                    EvaluatorRunsRuleViolationsTable innerJoin
                    EvaluatorRunsTable innerJoin
                    EvaluatorJobsTable innerJoin
                    IdentifiersTable

                join.select(
                    RuleViolationsTable.columns + IdentifiersTable.columns
                ).where { EvaluatorJobsTable.ortRunId eq ortRunId }
            }

        ListQueryResult(ruleViolationQueryResult.data, parameters, ruleViolationQueryResult.totalCount)
    }
}

private fun ResultRow.toRuleViolation(): RuleViolationWithIdentifier {
    return RuleViolationWithIdentifier(
        RuleViolationDao.wrapRow(this).mapToModel(),
        IdentifierDao.wrapRow(this).mapToModel()
    )
}
