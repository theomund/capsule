/*
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package main

import "core:encoding/json"
import "core:log"
import "core:os"

run :: proc() -> Error {
	data := os.read_entire_file(".devcontainer/devcontainer.json", context.allocator) or_return
	defer delete(data)

	metadata: Metadata
	json.unmarshal(data, &metadata) or_return
	defer destroy_metadata(metadata)

	log.info("Parsed metadata file:", metadata)

	return nil
}
