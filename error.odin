/*
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

package main

import "base:runtime"
import "core:encoding/json"
import "core:os"

Capsule_Error :: enum {
	None,
	Invalid_Command,
}

Error :: union #shared_nil {
	Capsule_Error,
	json.Unmarshal_Error,
	os.Error,
	runtime.Allocator_Error,
}
