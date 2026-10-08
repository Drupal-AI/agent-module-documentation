<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
LGP ("Lazy Guinea Pig") is a developer debugging library that logs variables to a temp file and tails it with a Drush command.
---
The module provides global logging helper functions you sprinkle into code while debugging: `lp()` (print_r), `ld()` (var_dump), `lx()` (var_export) and `lbt()` (backtrace), each writing to `lgp.log` in the system temp directory with a timestamp and calling function/file/line context. Variants (`lfp`/`lfd`/`lfx`) forward through the same helpers, and each accepts a `$use_stdout` flag to echo instead of writing. `hook_requirements()` surfaces the log file path on the status report. There are no web routes, forms, permissions or config.

A Drush command `lg-console` (alias `lgc`, class `LgpCommands`) continuously tails the last bytes of `lgp.log` to the terminal (a `while(true)` loop polling the file). The log directory can be overridden via the `lgp_temp_dir_func` state value (a callable). The project README explicitly warns "Don't use LGP in production" — it is a slacker's dev-time debugging aid, not production code.

Setup: require the module in a dev environment, enable it, add `lp($var)` etc. to code, and run `drush lgc` to watch the output.
---
- Log a variable's `print_r` output to a file with `lp()`.
- Dump a variable via `var_dump` with `ld()`.
- Export a variable via `var_export` with `lx()`.
- Log a backtrace (without args) with `lbt()`.
- Echo debug output to stdout instead of the file.
- Log only an array/object's keys and value types (`lp($var, TRUE)`).
- Tail the live debug log with `drush lg-console` / `drush lgc`.
- See timestamped caller context (function/file/line) on each entry.
- Find the log file path on the site status report.
- Debug a hook or service without configuring a logger.
- Override the temp directory via the `lgp_temp_dir_func` state callable.
- Quickly inspect data flow during development.
- Use `lfp`/`lfd`/`lfx` forwarding wrappers.
- Keep debug noise out of the DB/watchdog by writing to a file.
- Drop into any code path for ad-hoc tracing.
- Remove before shipping — not for production use.
