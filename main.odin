/*
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package main

import "core:log"
import "core:os"

run :: proc() -> Error {
	if len(os.args) < 2 {
		return Capsule_Error.Invalid_Command
	}

	switch os.args[1] {
	case "up":
		log.info("Creating development container")

		metadata := create_metadata() or_return
		defer destroy_metadata(metadata)

		container := create_container(metadata) or_return
		defer destroy_container(container)
	case:
		return Capsule_Error.Invalid_Command
	}

	return nil
}

main :: proc() {
	logger := log.create_console_logger()
	defer log.destroy_console_logger(logger)

	context.logger = logger

	when ODIN_DEBUG {
		tracker := create_tracker(logger)
		defer destroy_tracker(tracker)

		context = tracker.ctx
	}

	if err := run(); err != nil {
		log.error("Got error:", err)
		os.exit(1)
	}
}
