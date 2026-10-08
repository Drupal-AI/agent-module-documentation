# Hook — `hook_scss_preprocess_alter`

Just before each SCSS file is handed to the scssphp compiler, `ScssCompiler::compileScss()` fires
an alter over the raw stylesheet text, once through the theme system and once through the module
handler:

```php
$stylesheet = file_get_contents($scss_full_path);
\Drupal::theme()->alter('scss_preprocess', $stylesheet, $scss_full_path);
\Drupal::moduleHandler()->alter('scss_preprocess', $stylesheet, $scss_full_path);
$compiled = @$scss->compileString($stylesheet, $scss_filename);
```

So both modules and the active theme can rewrite the SCSS source (inject variables, prepend an
`@import`, string-replace tokens, etc.) before compilation.

## Implement it

Module (`mymodule.module`):

```php
/**
 * Implements hook_scss_preprocess_alter().
 *
 * @param string $stylesheet       The raw SCSS source (by reference).
 * @param string $scss_full_path   Absolute-ish path of the source file being compiled.
 */
function mymodule_scss_preprocess_alter(&$stylesheet, $scss_full_path) {
  // Prepend shared variables to every compiled file.
  $stylesheet = "\$brand: #0074bd;\n" . $stylesheet;
}
```

Theme (`mytheme.theme`) — same signature, e.g. `mytheme_scss_preprocess_alter(&$stylesheet, $scss_full_path)`.

Notes:
- `$stylesheet` is passed **by reference** — mutate it in place; there is no return value.
- The hook runs per source file on every (re)compile, for the theme root and each
  `additional_paths_to_watch` root. Use `$scss_full_path` to scope changes to specific files.

## Other hooks in the module (not integration points)

- `scss_help()` — `hook_help()` for the `scss.admin` route.
- `scss_update_8001()` — update hook that normalizes a bad `output_formatting` value to `expanded`.
- `scss_recursively_get_latest_modification_date($entry)` — internal helper used by `compileNeeded()`.
