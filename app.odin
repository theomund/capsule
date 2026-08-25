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
	defer destroy_metadata(metadata)

	container := create_container(engine, metadata) or_return
	defer destroy_container(container)

	switch os.args[1] {
	case "down":
		stop_container(container)
		remove_container(container)
	case "exec":
		execute_container(container)
	case "stop":
		stop_container(container)
	case "up":
		start_container(&container)
	case:
		return Capsule_Error.Invalid_Command
	}

	return nil
}
