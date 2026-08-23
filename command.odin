/*
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package main

import "core:log"
import "core:os"

run_command :: proc(command: []string) -> Error {
	log.info("Running shell command:", command)

	process := os.Process_Desc {
		command = command,
	}

	_, stdout, stderr := os.process_exec(process, context.allocator) or_return
	defer {
		delete(stdout)
		delete(stderr)
	}

	if len(stdout) != 0 {
		log.info("stdout:", string(stdout))
	}

	if len(stderr) != 0 {
		log.warn("stderr:", string(stderr))
	}

	return nil
}
