<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Status reports, the reset routine & Twig helpers

## `opcachectl_reset()` (`opcachectl.module`)

The single reset primitive used by both the confirm form and the control route. Returns `bool`:

- Returns `FALSE` (and logs an error) if `opcache_reset()` does not exist, or if
  `opcache_get_status()` reports OPcache disabled.
- If a restart is already pending, logs `info` and returns `TRUE` (treated as success — a flush is
  already queued).
- Logs an `info` on a successful `opcache_reset()`; logs an error and returns `FALSE` if it fails.
- All log lines go to the `opcachectl` logger channel and include `gethostname()` so per-node resets
  are distinguishable in a multi-web-node deployment.

`ConfirmResetOpcacheForm::submitForm()` calls it and adds a status/error message, then redirects to
`opcachectl.report.stats`. `OpcacheCtlController::controlPurge()` calls it and returns JSON.

## Controllers (`src/Controller/`)

- `OpcacheReportController::viewStatistics()` → render array `#theme => 'opcache_stats'`,
  `#cache max-age 0`.
- `OpcacheReportController::viewConfig()` → render array `#theme => 'opcache_config'`,
  `#cache max-age 0`.
- `OpcacheCtlController::controlGet()` → JSON of `opcache_get_status(FALSE)` — the `FALSE` argument
  omits the per-script cached-file list, returning only aggregate memory/statistics/state.
- `OpcacheCtlController::controlPurge()` → resets, then returns the post-reset status JSON (or HTTP
  500 on failure).
- `createControlResponse()` wraps every control response with `host` (`gethostname()`), `address`
  (`$_SERVER['SERVER_ADDR']`) and `timestamp` (`$_SERVER['REQUEST_TIME_FLOAT']`).

## Theme + preprocess (`opcachectl.module`)

`hook_theme()` defines `opcache_stats` and `opcache_config` (no variables declared; populated in
preprocess). Templates: `templates/opcache-stats.html.twig`, `templates/opcache-config.html.twig`.

- `opcachectl_preprocess_opcache_stats()` sets CSS classes, `hostname`, `now`, and
  `opcache_status = opcache_get_status()`. Adds a messenger **error** if OPcache is
  disabled/unavailable, a **warning** if `cache_full`, and **status** messages for
  `restart_pending` / `restart_in_progress`.
- `opcachectl_preprocess_opcache_config()` sets `opcache_config = opcache_get_configuration()['directives']`
  and `byte_size_values` (`opcache.memory_consumption`, `opcache.jit_buffer_size`,
  `opcache.max_file_size`) so the template can render those directives with the `format_size` filter.

## Runtime requirements (`opcachectl.install`)

`opcachectl_requirements('runtime')` reports:

- `opcache_loaded` — whether the `Zend OPcache` extension is loaded, plus product name + version.
- `opcache_enabled` — Enabled/Disabled, with a link to the config report when enabled.
- `opcache_reset_token` — whether remote reset is enabled and how (allowed addresses from
  `$settings['opcachectl_reset_remote_addresses']`, and/or a token in
  `$settings['opcachectl_reset_token']`); INFO severity when neither is set.

`opcachectl_runtime_requirements_alter()` unsets core's `php_opcache` requirement so this module's
richer entry replaces it on the status report.

## Twig extensions (`src/Twig/Extension/`, services in `opcachectl.services.yml`)

- `FormatSize` — filter `format_size`, wraps `ByteSizeMarkup::create($size ?? 0)` to render byte
  counts human-readably. Used for the `byte_size_values` directives.
- `TypeTest` — Twig test `of_type` (`of_type('array'|'bool'|'class'|'float'|'int'|'numeric'|'object'|'scalar'|'string')`,
  optional class name) and filter `get_type` (returns PHP `gettype()`), for rendering the loosely
  typed `opcache_get_status()` / directive arrays in the templates. Credited upstream to
  Craft-TwigTypeTest.
