/*
 * Copyright (C) 2022 The ORT Project Authors (See <https://github.com/oss-review-toolkit/ort-server/blob/main/NOTICE>)
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

package org.ossreviewtoolkit.server.services

import org.ossreviewtoolkit.server.dao.dbQuery
import org.ossreviewtoolkit.server.model.Organization
import org.ossreviewtoolkit.server.model.repositories.OrganizationRepository
import org.ossreviewtoolkit.server.model.repositories.ProductRepository
import org.ossreviewtoolkit.server.model.util.ListQueryParameters
import org.ossreviewtoolkit.server.model.util.OptionalValue

/**
 * A service providing functions for working with [organizations][Organization].
 */
class OrganizationService(
    private val organizationRepository: OrganizationRepository,
    private val productRepository: ProductRepository
) {
    /**
     * Create an organization.
     */
    suspend fun createOrganization(name: String, description: String?): Organization = dbQuery {
        organizationRepository.create(name, description)
    }.getOrThrow()

    /**
     * Create a product inside an [organization][organizationId].
     */
    suspend fun createProduct(name: String, description: String?, organizationId: Long) = dbQuery {
        productRepository.create(name, description, organizationId)
    }.getOrThrow()

    /**
     * Delete an organization by [organizationId].
     */
    suspend fun deleteOrganization(organizationId: Long): Unit = dbQuery {
        organizationRepository.delete(organizationId)
    }.getOrThrow()

    /**
     * Get an organization by [organizationId]. Returns null if the organization is not found.
     */
    suspend fun getOrganization(organizationId: Long): Organization? = dbQuery {
        organizationRepository.get(organizationId)
    }.getOrThrow()

    /**
     * List all organizations according to the given [parameters].
     */
    suspend fun listOrganizations(parameters: ListQueryParameters): List<Organization> = dbQuery {
        organizationRepository.list(parameters)
    }.getOrThrow()

    /**
     * List all products for an [organization][organizationId].
     */
    suspend fun listProductsForOrganization(organizationId: Long, parameters: ListQueryParameters) = dbQuery {
        productRepository.listForOrganization(organizationId, parameters)
    }.getOrThrow()

    /**
     * Update an organization by [organizationId] with the [present][OptionalValue.Present] values.
     */
    suspend fun updateOrganization(
        organizationId: Long,
        name: OptionalValue<String> = OptionalValue.Absent,
        description: OptionalValue<String?> = OptionalValue.Absent
    ): Organization = dbQuery {
        organizationRepository.update(organizationId, name, description)
    }.getOrThrow()
}
