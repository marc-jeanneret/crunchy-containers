#!/bin/bash

# Copyright 2017 Crunchy Data Solutions, Inc.
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# this is an example of creating a postgres database using
# the crunchy-primary template from the CLI

source $CCPROOT/examples/envvars.sh
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

PROJECT=jeff-project

#oc process --parameters -n $PROJECT crunchy-replica

oc process -n $PROJECT crunchy-replica \
	CCP_IMAGE_TAG=rhel7-9.6-1.6.0 \
	CCP_IMAGE_PREFIX=172.30.240.45:5000/$PROJECT \
	CCP_IMAGE_NAME=crunchy-postgres \
	SERVICE_NAME=replica \
	PG_PRIMARY_HOST=example \
	PG_PRIMARY_PORT=5432 \
	PG_PRIMARY_USER=primaryuser \
	PG_PRIMARY_PASSWORD=password \
	PVC_NAME=replica-pvc \
	PVC_SIZE=300M \
	PVC_ACCESS_MODE=ReadWriteMany \
	| oc create -f -
