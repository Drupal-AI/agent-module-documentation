<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `potx.inc` extraction API

potx's real reusable surface is a set of **procedural functions and constants** in `potx.inc`
(load with `module_load_include('inc', 'potx')` or `$moduleHandler->loadInclude('potx', 'inc')`),
used by potx's own Drush command and form and by external tools (localization server, Coder).

## Constants

- API version: `POTX_API_5/6/7/8`, `POTX_API_CURRENT` (= 8).
- Build mode: `POTX_BUILD_CORE` (0), `POTX_BUILD_MULTIPLE` (1), `POTX_BUILD_SINGLE` (2).
- String mode: `POTX_STRING_RUNTIME` (2), `POTX_STRING_INSTALLER` (1), `POTX_STRING_BOTH` (0).
- Status: `POTX_STATUS_SILENT/MESSAGE/CLI/STRUCTURED`.

## Core functions (typical flow)

```php
module_load_include('inc', 'potx');
module_load_include('inc', 'potx', 'potx.local');
potx_status('set', POTX_STATUS_SILENT);

potx_local_init($folder);                       // init local file bookkeeping
$files = _potx_explore_dir($folder . '/', '*', POTX_API_CURRENT, TRUE);
foreach ($files as $file) {
  _potx_process_file($file, 0, '_potx_save_string', '_potx_save_version', POTX_API_CURRENT);
}
potx_finish_processing('_potx_save_string', POTX_API_CURRENT);
_potx_build_files(POTX_STRING_RUNTIME, POTX_BUILD_SINGLE, 'general',
  '_potx_save_string', '_potx_save_version', '_potx_get_header');
_potx_write_files();                            // writes .pot to CWD (or streams if $http_filename)
```

- `_potx_process_file($path, $strip_prefix, $save_cb, $version_cb, $api)` — parse one file
  (dispatches to PHP/JS/Twig/YAML parsers).
- `_potx_explore_dir($path, $basename, $api, $skip_self)` — enumerate scannable files.
- `_potx_save_string(...)` / `_potx_save_version(...)` — default collector callbacks; call
  `_potx_save_string(NULL, NULL, NULL, 0, POTX_STRING_RUNTIME)` to read the collected strings back.
- `_potx_build_files(...)` — assemble template/`.po` content from collected strings.
- `_potx_write_files($http_filename = NULL, $disposition = 'inline')` — write `.pot` files to
  the current directory, or stream to the browser when `$http_filename` is set.
- `potx_status($op, ...)` — control/collect messages and errors.

The parser also handles `_potx_find_t_calls`, `_potx_find_format_plural_calls`,
`_potx_parse_twig_file`, `_potx_parse_yaml_file`, `_potx_process_config_schema`, plugin
annotations, and constraint messages — you normally drive these through `_potx_process_file()`.
