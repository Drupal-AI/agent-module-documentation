<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Hooks: custom separators for the Human Friendly formatter

Declared in `duration_field.api.php`. These add options to the **`separator`** select on the
Human Friendly formatter (`duration_human_display`). The formatter calls `invokeAll()` on both
hooks, so implement **both** together.

## `hook_duration_field_separators()`

Return machine-name → actual-separator-string. The string is inserted between duration parts.

```php
function mymodule_duration_field_separators() {
  return [
    'bullet' => ' • ',
    'slash'  => ' / ',
  ];
}
```

## `hook_duration_field_labels()`

Return the human labels for those machine names, in **both** `capitalized` and `lowercase`
groups (the formatter uses capitalized in the options list, lowercase in the summary).

```php
function mymodule_duration_field_labels() {
  return [
    'capitalized' => ['bullet' => t('Bullets'), 'slash' => t('Slashes')],
    'lowercase'   => ['bullet' => t('bullets'), 'slash' => t('slashes')],
  ];
}
```

Built-in separators (always present): `space` (` `), `hyphen` (` - `), `comma` (`, `),
`newline` (`<br />`). Your keys are appended to those. If you implement one hook you must
implement the other, or the formatter's label lookup falls back to the raw machine name.
