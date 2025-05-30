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

package org.eclipse.apoapsis.ortserver.model

import kotlinx.serialization.Serializable

/**
 * A data class representing the declaration of an environment variable.
 *
 * This class can be used to describe environment variables that are referenced during an ORT run. When triggering an
 * ORT run, the list of required variables can be specified. During the Analyzer step, these variables are then
 * defined. The variable values are obtained from secrets, which are referenced by their names. Either a value or a
 * secret name can be provided.
 */
@Serializable
data class EnvironmentVariableDeclaration(
    /** The name of the environment variable. */
    val name: String,

    /** The name of the [Secret] that contains the value of the variable. */
    val secretName: String? = null,

    /** The value of the environment variable. */
    val value: String? = null
)
