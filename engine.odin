/*
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package main

import "core:log"

Engine :: struct {
	path: string,
}

create_engine :: proc() -> (engine: Engine, err: Error) {
	log.info("Determining the container engine")

	choices := []string{"docker", "podman"}

	for choice in choices {
		state := run_command([]string{choice, "info"}) or_continue

		if state.success {
			engine.path = choice
			log.infof("Determined '%s' to be the container engine", engine.path)

			return
		}
	}

	return engine, .Invalid_Engine
}
