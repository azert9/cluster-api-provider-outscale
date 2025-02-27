#!/usr/bin/bash
# Copyright 2022 The Kubernetes Authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
set -o errexit
set -o nounset
set -o pipefail
set -o verbose

ROOT_PATH=$(git rev-parse --show-toplevel)

boilerDir="${ROOT_PATH}/hack/boilerplate"
boiler="${boilerDir}/boilerplate.py"

run_boilerplate(){
	boilerplate_file=()
	while IFS=$'\n' read -r line; do
	  boilerplate_file+=( "$line" )
	done < <("${boiler}" "$@")

	if [[ ${#boilerplate_file[@]} -gt 0 ]]; then
	  for file in "${boilerplate_file[@]}"; do
   	    echo "Boilerplate header is wrong for: ${file}" >&2
  	done
  exit 1
fi
}

run_boilerplate "$@"
