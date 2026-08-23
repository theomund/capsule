/*
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package main

import "core:fmt"

Container :: struct {
	name: string,
}

create_container :: proc(metadata: Metadata) -> (container: Container, err: Error) {
	image := create_image(metadata) or_return

	container.name = fmt.aprintf("capsule_%s", metadata.name)

	run_command([]string{"docker", "run", "-d", "--name", container.name, image.name}) or_return

	return
}

destroy_container :: proc(container: Container) -> Error {
	delete(container.name) or_return

	return nil
}
