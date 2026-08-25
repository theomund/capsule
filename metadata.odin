/*
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package main

import "core:encoding/json"
import "core:log"
import "core:os"

Metadata :: struct {
	name:           string,
	build:          struct {
		dockerfile: string,
	},
	customizations: struct {
		vscode: struct {
			extensions: []string,
			settings:   map[string]string,
		},
	},
	securityOpt:    []string,
}

create_metadata :: proc() -> (metadata: Metadata, err: Error) {
	log.info("Parsing metadata file")

	paths := []string{".devcontainer/devcontainer.json", ".devcontainer.json"}

	data: []byte
	defer delete(data)

	for path in paths {
		if data, err = os.read_entire_file(path, context.allocator); err == nil {
			break
		}
	}

	json.unmarshal(data, &metadata) or_return

	log.debug(metadata)

	log.info("Parsed metadata file")

	return
}

destroy_metadata :: proc(metadata: Metadata) -> Error {
	delete(metadata.name) or_return
	delete(metadata.build.dockerfile) or_return

	for extension in metadata.customizations.vscode.extensions {
		delete(extension) or_return
	}

	delete(metadata.customizations.vscode.extensions) or_return

	for key, value in metadata.customizations.vscode.settings {
		delete(key) or_return
		delete(value) or_return
	}

	delete(metadata.customizations.vscode.settings) or_return

	for option in metadata.securityOpt {
		delete(option) or_return
	}

	delete(metadata.securityOpt) or_return

	return nil
}
