/*
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package main

import "core:fmt"
import "core:log"

Image :: struct {
	name: string,
}

create_image :: proc(engine: Engine, metadata: Metadata) -> (image: Image, err: Error) {
	log.info("Creating development container image")

	dockerfile := fmt.aprintf(".devcontainer/%s", metadata.build.dockerfile)
	defer delete(dockerfile)

	image.name = fmt.aprintf("capsule/%s", metadata.name)

	run_command([]string{engine.path, "build", "-f", dockerfile, "-t", image.name, "."}) or_return

	log.info("Created development container image")

	return
}

destroy_image :: proc(image: Image) {
	delete(image.name)
}
