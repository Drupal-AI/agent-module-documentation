# H5P hooks

From `h5p.api.php`. Implement in your module to customise H5P content/behaviour.

| Hook | Use |
|---|---|
| `hook_h5p_semantics_alter(&$semantics, $machine_name, $major_version, $minor_version)` | Change a library's semantics — add fields, change a widget, allow extra HTML tags (e.g. add `<h4>` to `H5P.Text 1.0`). |
| `hook_h5p_filtered_params_alter(&$filtered)` | Alter an H5P's filtered parameters/behaviour before render (e.g. disable retry/solution buttons in a quiz context). `$filtered` is a JSON object. |
| `hook_h5p_styles_alter(&$styles, $libraries, $mode)` | Add CSS to rendered H5Ps. `$styles` are objects with `path` + `version`; `$mode` is `editor`/`div`/`iframe`/`external`. |
| `hook_h5p_scripts_alter(&$scripts, $libraries, $mode)` | Add JS to rendered H5Ps (same shape as styles). |
| `hook_h5p_library_installed($libraryData, $isNew)` | React after a library is installed/updated (`$libraryData` is the `library.json` contents; `$isNew` TRUE for a new library). Notification only — not for altering input. |

Example — allow an extra tag in a text library:

```php
function mymodule_h5p_semantics_alter(&$semantics, $machine_name, $major_version, $minor_version) {
  if ($machine_name === 'H5P.Text' && $major_version == 1 && $minor_version == 0) {
    $semantics[0]->tags[] = 'h4';
  }
}
```

Example — inject a stylesheet into rendered H5Ps of a given library:

```php
function mymodule_h5p_styles_alter(&$styles, $libraries, $mode) {
  if (isset($libraries['H5P.MultiChoice'])) {
    $styles[] = (object) [
      'path' => \Drupal::service('extension.list.module')->getPath('mymodule') . '/h5p-overrides.css',
      'version' => '?ver=1',
    ];
  }
}
```
