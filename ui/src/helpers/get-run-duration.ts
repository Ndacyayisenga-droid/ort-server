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

export function calculateDuration(
  createdAt: string,
  finishedAt: string
): string {
  // Convert the timestamps to Date objects
  const createdAtDate = new Date(createdAt);
  const finishedAtDate = new Date(finishedAt);

  // Calculate the difference in milliseconds
  const durationMs = finishedAtDate.getTime() - createdAtDate.getTime();

  // Convert the duration from milliseconds to seconds
  const durationSec = Math.floor(durationMs / 1000);

  // Calculate hours, minutes, and seconds
  const hours = Math.floor(durationSec / 3600);
  const minutes = Math.floor((durationSec % 3600) / 60);
  const seconds = durationSec % 60;

  // Format the duration as "xh ym zs", omitting zero values except:
  // - when the duration is 0 -> "0s"
  // - when minutes are 0 but hours or seconds are not -> "1h 0m 26s"
  let formattedDuration = '';
  if (hours > 0) {
    formattedDuration += `${hours}h `;
  }
  if (minutes > 0 || (hours > 0 && seconds > 0)) {
    formattedDuration += `${minutes}m `;
  }
  if (seconds > 0 || (hours == 0 && minutes == 0)) {
    formattedDuration += `${seconds}s`;
  }

  // Trim any trailing space and return
  return formattedDuration.trim();
}

if (import.meta.vitest) {
  const { it, expect } = import.meta.vitest;
  it('calculateDuration', () => {
    expect(
      calculateDuration('2024-06-11T13:07:45Z', '2024-06-11T13:08:15Z')
    ).toBe('30s');
    expect(
      calculateDuration('2024-06-11T13:07:45Z', '2024-06-11T13:12:15Z')
    ).toBe('4m 30s');
    expect(
      calculateDuration('2024-06-11T13:00:00Z', '2024-06-11T14:00:01Z')
    ).toBe('1h 0m 1s');
    expect(
      calculateDuration('2024-06-11T13:00:00Z', '2024-06-22T14:42:01Z')
    ).toBe('265h 42m 1s');
  });
}
