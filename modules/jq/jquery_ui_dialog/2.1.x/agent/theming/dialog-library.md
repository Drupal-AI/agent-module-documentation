<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Using the `jquery_ui_dialog/dialog` library

## Attach it

From a render array:

```php
$build['#attached']['library'][] = 'jquery_ui_dialog/dialog';
```

From your own `mymodule.libraries.yml`:

```yaml
my-dialog-ui:
  version: 1.x
  js:
    js/my-dialog.js: {}
  dependencies:
    - jquery_ui_dialog/dialog
```

From a form: `$form['#attached']['library'][] = 'jquery_ui_dialog/dialog';`
From a Twig template: `{{ attach_library('jquery_ui_dialog/dialog') }}`

## Migrating off core

`core/jquery.ui.dialog` was deprecated and removed from Drupal core. The one-line fix is a
search/replace:

```
core/jquery.ui.dialog   →   jquery_ui_dialog/dialog
```

Same for the siblings the dialog needs: `core/jquery.ui.button` → `jquery_ui_button/button`,
`core/jquery.ui.draggable` → `jquery_ui_draggable/draggable`,
`core/jquery.ui.resizable` → `jquery_ui_resizable/resizable`.

For **new** code prefer Drupal core's own dialog system instead of jQuery UI:
`core/drupal.dialog`, `core/drupal.dialog.ajax`, and the `OpenModalDialogCommand` AJAX command.

## What the library actually resolves to

`jquery_ui_dialog` has no `*.libraries.yml`. The base `jquery_ui` module implements
`hook_library_info_alter()` (`jquery_ui_library_info_alter()`), loads
`jquery_ui/jquery_ui.libraries.data.json`, and injects the definitions for each
`jquery_ui_*` extension — prefixing every asset path with the `jquery_ui` module path. So on a
live site the definition of `jquery_ui_dialog/dialog` is:

| Property | Value |
|---|---|
| version | `1.13.2` |
| js | `modules/contrib/jquery_ui/assets/vendor/jquery.ui/ui/widgets/dialog-min.js` (minified, weight -11, group -100) |
| css | `modules/contrib/jquery_ui/assets/vendor/jquery.ui/themes/base/dialog.css` |
| license | Public Domain, GPL-compatible |
| dependencies | `core/jquery`, `jquery_ui_button/button`, `jquery_ui_draggable/draggable`, `jquery_ui/mouse`, `jquery_ui_resizable/resizable`, `jquery_ui/internal.focusable`, `jquery_ui/internal.keycode`, `jquery_ui/position`, `jquery_ui/internal.safe-active-element`, `jquery_ui/internal.safe-blur`, `jquery_ui/internal.tabbable`, `jquery_ui/internal.unique-id`, `jquery_ui/internal.version`, `jquery_ui/widget`, `jquery_ui/internal.widget-css` |

You never attach those dependencies yourself — Drupal resolves them transitively.

Inspect it on a running site:

```bash
drush php:eval 'print json_encode(\Drupal::service("library.discovery")->getLibraryByName("jquery_ui_dialog", "dialog"), JSON_PRETTY_PRINT);'
drush php:eval 'print implode(", ", array_keys(\Drupal::service("library.discovery")->getLibrariesByExtension("jquery_ui_dialog")));'
```

## Overriding or altering it

Because the definition arrives through `hook_library_info_alter()`, you can change it from your
own module the same way — order is by module weight, and your alter runs on the already-merged
array:

```php
function mymodule_library_info_alter(array &$libraries, string $extension): void {
  if ($extension === 'jquery_ui_dialog' && isset($libraries['dialog'])) {
    $libraries['dialog']['version'] = '1.13.2-patched';
  }
}
```

Themes can do the same declaratively with `libraries-override:` / `libraries-extend:` in
`mytheme.info.yml`, keyed on `jquery_ui_dialog/dialog`.

## Non-surface

No permissions, no routes, no services, no plugins, no Drush commands, no config schema and
no settings form — there is nothing to configure. Enabling the module (and its four
dependencies) is the entire installation.
