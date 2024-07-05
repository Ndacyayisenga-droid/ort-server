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

package org.eclipse.apoapsis.ortserver.api.v1.model

import kotlinx.serialization.Serializable

/**
 * A response object for returning paged lists of entities.
 */
@Serializable
data class PagedResponse<E>(
    /** The list of entities to return. */
    val data: List<E>,

    /** The [PagingOptions] used for the request. */
    val options: PagingOptions
)

/**
 * A response object for returning paged lists of entities.
 */
@Serializable
data class PagedResponse2<E>(
    /** The list of returned entities. */
    val data: List<E>,

    /** The pagination information for the result set. */
    val pagination: PagingData
)

@Serializable
data class PagingOptions(
    /** An optional limit for the number of items to return. */
    val limit: Int? = null,

    /**
     * An optional offset for the items to return. This is used to skip a number of items from the beginning of the
     * result set.
     */
    val offset: Long? = null,

    /**
     * An optional list of properties by which the result set should be sorted.
     */
    val sortProperties: List<SortProperty>? = null
)

@Serializable
data class PagingData(
    /** The limit for the number of items to return. */
    val limit: Int,

    /** The offset for the items to return. */
    val offset: Long,

    /** The total count of items. */
    val totalCount: Long,

    /** The properties by which the result set was sorted. */
    val sortProperties: List<SortProperty>
)

@Serializable
/**
 * A data class defining a property by which a query result should be sorted.
 */
data class SortProperty(
    /** The name of the property to use for sorting. */
    val name: String,

    /** The direction in which the result set should be sorted. */
    val direction: SortDirection
)

@Serializable
/**
 * An enum class defining constants for the direction in which properties are sorted.
 */
enum class SortDirection {
    /** Constant for _ascending_ sort direction. */
    ASCENDING,

    /** Constant for _descending_ sort direction. */
    DESCENDING
}
