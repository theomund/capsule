/*
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package main

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

destroy_metadata :: proc(metadata: Metadata) {
	delete(metadata.name)
	delete(metadata.build.dockerfile)

	for extension in metadata.customizations.vscode.extensions {
		delete(extension)
	}

	delete(metadata.customizations.vscode.extensions)

	for key, value in metadata.customizations.vscode.settings {
		delete(key)
		delete(value)
	}

	delete(metadata.customizations.vscode.settings)

	for option in metadata.securityOpt {
		delete(option)
	}

	delete(metadata.securityOpt)
}
