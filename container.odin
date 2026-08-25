/*
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package main

import "core:fmt"
import "core:log"
import "core:os"

Container :: struct {
	name:     string,
	engine:   Engine,
	metadata: Metadata,
}

create_container :: proc(
	engine: Engine,
	metadata: Metadata,
) -> (
	container: Container,
	err: Error,
) {
	container.name = fmt.aprintf("capsule_%s", metadata.name)
	container.engine = engine
	container.metadata = metadata

	return
}

destroy_container :: proc(container: Container) -> Error {
	delete(container.name) or_return

	destroy_metadata(container.metadata) or_return

	return nil
}

execute_container :: proc(container: Container) -> Error {
	log.info("Executing development container command")

	run_command([]string{container.engine.path, "exec", container.name, os.args[2]}) or_return

	log.info("Executed development container command")

	return nil
}

remove_container :: proc(container: Container) -> Error {
	log.info("Removing development container")

	run_command([]string{container.engine.path, "rm", container.name}) or_return

	log.info("Removed development container")

	return nil
}

start_container :: proc(container: ^Container) -> Error {
	log.info("Starting development container")

	image := create_image(container.engine, container.metadata) or_return
	defer destroy_image(image)

	run_command(
		[]string {
			container.engine.path,
			"run",
			"-d",
			"--name",
			container.name,
			image.name,
			"sleep",
			"infinity",
		},
	) or_return

	log.info("Started development container")

	return nil
}

stop_container :: proc(container: Container) -> Error {
	log.info("Stopping development container")

	run_command([]string{container.engine.path, "stop", container.name}) or_return

	log.info("Stopped development container")

	return nil
}
