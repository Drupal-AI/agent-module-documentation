<!-- SPDX-License-Identifier: LicenseRef-DXPR-Commercial -->
# Hooks (`dxpr_builder.api.php`)

Two alter-style hooks let you extend the builder's palette. Both are also extendable from a
theme's `.info.yml`.

## `hook_dxpr_builder_classes(&$dxpr_builder_classes)`
Add utility CSS classes to the builder's class selectbox. Keys are one or more space-separated
classes; values are labels. A key like `optgroup-<name>` starts a new option group.
```php
function my_module_dxpr_builder_classes(&$classes) {
  $classes['optgroup-my-group'] = t('My option group');
  $classes['my-class'] = t('My label');
}
```

## `hook_dxpr_builder_buttons_folders(&$dxpr_buttons_folders)`
Add folders that contain HTML files describing button styles. DXPR scans the paths for `.html`
files and extracts Bootstrap `btn` class combinations to build button-style options.
```php
function my_module_dxpr_builder_buttons_folders(&$folders) {
  $folders[] = dirname(__FILE__) . '/dxpr_elements/Buttons';
}
```

That is the full public hook surface. There are no data/entity hooks beyond these; runtime
behavior is otherwise driven by config (`dxpr_builder.settings`, profiles, templates) and the
services in [../api/services-plugins.md](../api/services-plugins.md).
