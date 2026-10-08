<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `hook_default_wrap_tags_alter()`

The set of wrapper tags offered by the formatter's **Field wrapper** select is alterable. The
default set is `div`, `h1`–`h6`, `span`.

```php
/**
 * Implements hook_default_wrap_tags_alter().
 *
 * @param array $wrappers  Map of tag => human label.
 */
function mymodule_default_wrap_tags_alter(array &$wrappers) {
  $wrappers['p'] = t('P');          // add a paragraph wrapper option
  // unset($wrappers['span']);      // or remove one
}
```

Notes:
- Declared in `text_field_formatter.api.php`; invoked via
  `$this->moduleHandler->alter('default_wrap_tags', $wrappers)` in
  `TextFieldFormatter::defaultWrapTagOptions()`.
- The tag **`a`** is special-cased: if any alter adds `a`, the formatter removes it and shows a
  warning ("Tag \"a\" is not allowed here since it can conflict with other functional."), because
  it would clash with the entity-link feature.
- Keys are the actual HTML tag names used for the wrapper; values are the labels shown in the
  select.

This is the only hook the module invites. There are no services or other public APIs to call.
