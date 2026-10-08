<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `scss_compiler` service

Service id **`scss_compiler`** (`ScssCompilerService implements ScssCompilerInterface`).
Cache folder constant `CACHE_FOLDER = 'public://scss_compiler'`.

## Methods

| Method | Purpose |
|---|---|
| `compile(array $scss_file, $flush = FALSE)` | Compile one source and **write** the CSS file. Picks the plugin by the source extension via `scss_compiler.settings:plugins`. Skips unchanged files unless `$flush` (when `check_modify_time` is on). |
| `compileAll($all = FALSE, $flush = FALSE)` | Compile every source in the compile list (`$all` = across all themes). |
| `flushCache()` | Delete `public://scss_compiler`, recompile all, clear CSS aggregation. |
| `getCompileList($all = FALSE)` / `setCompileList(array $files)` | Read/append the cached list of sources to compile (per active theme). |
| `buildCompilationFileInfo(array $info)` | Turn a Drupal CSS asset entry into the `$scss_file` info array (`name`, `namespace`, `assets_path`, `source_path`, `css_path`). |
| `getOption($option)` | Read one `scss_compiler.settings` value. |
| `isCacheEnabled()` / `getCacheFolder()` | Compiled-cache flag / folder. |
| `getAdditionalImportPaths()` | Runs `hook_scss_compiler_import_paths_alter`. |
| `getVariables()` | Returns a `ScssCompilerAlterStorage` after `hook_scss_compiler_variables_alter`. |
| `replaceTokens($path)` | Resolve a leading `@namespace` token to a module/theme path. |

## The `$scss_file` info array

`compile()` expects (as produced by `buildCompilationFileInfo()`):

```php
[
  'name'        => 'style',                      // basename without extension
  'namespace'   => 'my_theme',                   // module/theme the source belongs to
  'assets_path' => '/themes/custom/my_theme/',   // for relative asset urls (optional)
  'source_path' => '/abs/path/style.scss',       // the source to read
  'css_path'    => '/abs/path/out/style.css',    // where the compiled CSS is written
]
```

## Programmatic compile example

```php
$svc = \Drupal::service('scss_compiler');
$info = [
  'source_path' => $src,     // absolute path to a .scss file
  'css_path'    => $out,     // absolute path for the .css output
  'namespace'   => 'olivero',
  'name'        => 'style',
  'assets_path' => '',
];
$svc->compile($info, TRUE);  // TRUE = force even if unchanged; writes $out (+ .map if sourcemaps)
```

The chosen compiler (default `scss_compiler_scssphp`) reads `source_path`, applies the
`output_format` formatter, resolves `@import`s (source dir, `DRUPAL_ROOT`, `@namespace` tokens,
and any `getAdditionalImportPaths()`), injects `getVariables()`, and returns the CSS string,
which the service writes to `css_path`. With default `output_format: compressed`,
`.box { .title { color: #123456 } }` becomes `.box .title{color:#123456}`.

Module-level convenience: `scss_compiler_recompile()` calls `flushCache()`.
