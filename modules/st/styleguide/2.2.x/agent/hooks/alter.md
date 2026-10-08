<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `hook_styleguide_alter()` and `hook_styleguide_info_alter()`

## `hook_styleguide_alter(&$items)`

Declared in `styleguide.api.php`. Runs after all Styleguide plugins' `items()` are merged, so
you can add, remove, or wrap individual preview items without writing a plugin.

```php
/**
 * Alter styleguide elements.
 */
function mymodule_styleguide_alter(array &$items) {
  // Wrap the 'text' test in a custom class.
  $items['text']['content'] = '<div class="mytestclass">' . $items['text']['content'] . '</div>';
  // Remove the headings tests.
  unset($items['headings']);
}
```

Each `$items[<key>]` typically has `title`, `content`, and optionally `group`. Keys come from
the shipped plugins (e.g. `text`, `headings`, `table`, `links`, …) and any custom plugins.

## `hook_styleguide_info_alter(&$definitions)`

The plugin manager calls `alterInfo('styleguide_info')`, so this hook alters the **plugin
definitions** themselves (e.g. remove a shipped plugin from discovery). Prefer
`hook_styleguide_alter()` for tweaking individual elements; use `styleguide_info` only to
change which plugins are registered.
