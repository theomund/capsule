/*
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package main

import "core:fmt"

Container :: struct {
	name:  string,
	image: Image,
}

create_container :: proc(metadata: Metadata) -> (container: Container, err: Error) {
	engine := create_engine() or_return

	container.name = fmt.aprintf("capsule_%s", metadata.name)
	container.image = create_image(engine, metadata) or_return

	run_command(
		[]string{engine.path, "run", "-d", "--name", container.name, container.image.name},
	) or_return

	return
}

destroy_container :: proc(container: Container) -> Error {
	delete(container.name) or_return

	destroy_image(container.image)

	return nil
}
