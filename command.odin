/*
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package main

import "core:log"
import "core:os"

run_command :: proc(command: []string) -> (state: os.Process_State, err: Error) {
	log.info("Running command:", command)

	process := os.Process_Desc {
		command = command,
	}

	stdout, stderr: []byte

	state, stdout, stderr = os.process_exec(process, context.allocator) or_return
	defer {
		delete(stdout)
		delete(stderr)
	}

	if len(stdout) != 0 {
		log.info(string(stdout))
	}

	if len(stderr) != 0 {
		log.warn(string(stderr))
	}

	return state, nil
}
