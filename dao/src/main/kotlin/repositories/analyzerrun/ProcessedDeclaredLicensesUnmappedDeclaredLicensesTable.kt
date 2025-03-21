/*
 * Copyright (C) 2023 The ORT Server Authors (See <https://github.com/eclipse-apoapsis/ort-server/blob/main/NOTICE>)
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

package org.eclipse.apoapsis.ortserver.dao.repositories.analyzerrun

import org.jetbrains.exposed.sql.Table

/**
 * An intermediate table to associate [ProcessedDeclaredLicensesTable] with [UnmappedDeclaredLicensesTable].
 */
object ProcessedDeclaredLicensesUnmappedDeclaredLicensesTable :
    Table("processed_declared_licenses_unmapped_declared_licenses") {
    val processedDeclaredLicenseId = reference("processed_declared_license_id", ProcessedDeclaredLicensesTable)
    val unmappedDeclaredLicenseId = reference("unmapped_declared_license_id", UnmappedDeclaredLicensesTable)

    override val primaryKey: PrimaryKey
        get() = PrimaryKey(processedDeclaredLicenseId, unmappedDeclaredLicenseId, name = "${tableName}_pkey")
}
