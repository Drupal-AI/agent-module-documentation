# API — the compiler service

**Service:** `scss.compiler` → `Drupal\scss\Services\ScssCompiler`
implements `Drupal\scss\Services\ScssCompilerInterface`.
**Constructor args:** `@config.factory`, `@request_stack`, `@state`.

```php
$compiler = \Drupal::service('scss.compiler');
$compiler->force = TRUE;      // compile even if nothing changed
$compiler->compileScss();     // returns bool (FALSE if invalid/not needed)
```

## Public surface

| Member | Signature | Purpose |
|--------|-----------|---------|
| `$force` | `bool` (public) | Force a build regardless of `compileNeeded()`. |
| `$testing` | `bool` (public) | Compile in memory; print CSS as a message, skip writes & source maps. |
| `compileScss()` | `: bool` | Validate, then compile each configured `.scss` and write `.css`/`.css.map`. |
| `checkConfiguration()` | `: bool` | Validate library present, source dir exists, dest writable, files exist; **throws `ConfigException`** on failure (and adds Messenger errors). |
| `getListToCompile()` | `: array` | Build the per-directory work list (see structure below). Memoized. |
| `getScssFilesList($directory)` | `: array` | Recursive `.scss` list; skips dirs, `_`-prefixed partials, non-`.scss`, and `files_to_ignore`. |
| `compileNeeded()` | `: bool` | TRUE if any watched source is newer than the stored `scss_last_compile_date_<dir>` state. |

`getListToCompile()` returns one entry per watched root (the configured theme's path plus each
`additional_paths_to_watch` line), each shaped:

```php
[
  'directory_path'            => 'themes/custom/mytheme',
  'scss_directory_full_path'  => 'themes/custom/mytheme/scss',
  'css_directory_full_path'   => 'themes/custom/mytheme/css',
  'files'                     => ['style.scss', 'sub/other.scss'],
]
```

## How a compile runs (`compileScss()`)

1. `checkConfiguration()`; return FALSE on `ConfigException`.
2. Return FALSE early if `!compileNeeded() && !$force`.
3. For each watched dir (skipping non-writable `css` dirs), for each source file:
   - `new \ScssPhp\ScssPhp\Compiler()`; `setImportPaths(<scss dir>)`.
   - `setOutputStyle(OutputStyle::from(<output_formatting>))`.
   - If `source_maps` and not testing: `setSourceMap(Compiler::SOURCE_MAP_FILE)` + map options.
   - Read the file, fire the alter hooks (see [../hooks/scss_preprocess.md](../hooks/scss_preprocess.md)),
     then `compileString($stylesheet, $scss_filename)` (wrapped in try/catch → Messenger error, continue).
   - Write `<name>.css` (+ `<name>.css.map`) into the `css` dir; record
     `state->set('scss_last_compile_date_' . str_replace('/', '%', $dir), time())`.

## Request-time triggering (`scss.monitor`)

`Drupal\scss\Services\ScssMonitor` (service `scss.monitor`, tagged `event_subscriber`) subscribes
to `KernelEvents::REQUEST` → `compileIfNeeded()`. It returns early when the user is anonymous and
`compile_logged_out` is unset, or when `active` is off; otherwise it calls `compileScss()`. There
is no cron hook — builds happen on page requests or on demand (form buttons / Drush).

## Library resolution

`checkConfiguration()` requires class `\ScssPhp\ScssPhp\Compiler` (composer `scssphp/scssphp:^2`).
If absent it falls back to `include`-ing a legacy `sites/all/libraries/scssphp/scss.inc.php`, and
errors via Messenger if neither is found.

**Source of compiled input:** on-disk `.scss` files under the configured theme/module roots only;
all paths derive from `scss.settings` (admin-set). The injected request stack is not used to select
sources.
