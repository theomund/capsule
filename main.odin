package main

import "core:log"
import "core:os"

main :: proc() {
	logger := log.create_console_logger()
	defer log.destroy_console_logger(logger)

	context.logger = logger

	when ODIN_DEBUG {
		tracker := create_tracker(logger)
		defer destroy_tracker(tracker)

		context = tracker.ctx
	}

	if err := run(); err != nil {
		log.error("Got error:", err)
		os.exit(1)
	}
}
