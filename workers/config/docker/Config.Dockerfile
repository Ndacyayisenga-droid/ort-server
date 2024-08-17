# syntax=docker/dockerfile:1.9

# This Dockerfile is the base image for the Config worker Docker image.

# Copyright (C) 2022 The ORT Server Authors (See <https://github.com/eclipse-apoapsis/ort-server/blob/main/NOTICE>)
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# SPDX-License-Identifier: Apache-2.0
# License-Filename: LICENSE

# When updating this version make sure to keep it in sync with the other worker Dockerfiles and libs.version.toml.
FROM eclipse-temurin:17.0.12_7-jdk-jammy@sha256:4e391159859c215f7ae046f7b1f9408479ecc823e765466474708b6a1b9baf95

ARG USERNAME=ort
ARG USER_ID=1000
ARG USER_GID=$USER_ID
ARG HOMEDIR=/home/ort
ENV HOME=$HOMEDIR
ENV USER=$USERNAME

# Non privileged user
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd \
    --uid $USER_ID \
    --gid $USER_GID \
    --shell /bin/bash \
    --home-dir $HOMEDIR \
    --create-home $USERNAME

# Make sure the user executing the container has access rights in the home directory.
RUN chgrp -R 0 /home/ort && chmod -R g+rwX /home/ort

USER $USERNAME
WORKDIR $HOMEDIR

ENTRYPOINT ["/bin/bash"]
