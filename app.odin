/*
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package main

import "core:os"

run :: proc() -> Error {
	if len(os.args) < 2 {
		return Capsule_Error.Invalid_Command
	}

	engine := detect_engine() or_return
	metadata := create_metadata() or_return

	container := create_container(engine, metadata) or_return
	defer destroy_container(container)

	switch os.args[1] {
	case "down":
		stop_container(container) or_return
		remove_container(container) or_return
	case "exec":
		execute_container(container) or_return
	case "stop":
		stop_container(container) or_return
	case "up":
		start_container(&container) or_return
	case:
		return Capsule_Error.Invalid_Command
	}

	return nil
}
