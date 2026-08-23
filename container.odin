/*
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package main

Container :: struct {
	metadata: Metadata,
}

create_container :: proc(metadata: Metadata) -> Container {
	return {metadata}
}

destroy_container :: proc(container: Container) -> Error {
	destroy_metadata(container.metadata) or_return

	return nil
}
