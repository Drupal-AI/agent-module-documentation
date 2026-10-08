<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# LGP — logging helpers & Drush

## Logging functions (call from code while debugging)
- `lp($var, $keys_only = FALSE, $use_stdout = FALSE)` — print_r; `$keys_only` logs keys + value types.
- `ld($var, $use_stdout = FALSE)` — var_dump.
- `lx($var, $use_stdout = FALSE)` — var_export.
- `lbt($ignore_args = TRUE, $use_stdout = FALSE)` — backtrace (self removed from stack).
- `lfp()/lfd()/lfx()` — variadic forwarders to `lp/ld/lx`.

Each entry is prefixed with a timestamp and `function ...() in <file> on line <n>` context and appended to `<temp>/lgp.log`. If the file/dir is not writable an error is shown via the messenger.

## Drush command
- `drush lg-console` (alias `drush lgc`) — opens `lgp.log` and continuously tails new lines (`fseek` to end, `while(true)` polling every 0.1s). Handles truncation by seeking back to the start. Requires the module enabled.

## Temp directory
`lgp_get_temp_dir()` returns `\Drupal::state()->get('lgp_temp_dir_func')` (a callable, default `lgp_temp_dir`), so the log location is derived from `TMP/TEMP/TMPDIR` or PHP's temp dir. Intended for development only.
