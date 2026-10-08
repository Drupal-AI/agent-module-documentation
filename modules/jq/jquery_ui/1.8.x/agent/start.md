<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# jQuery UI (jquery_ui) — agent index

Re-provides the jQuery UI **1.13.2** asset library (JS + CSS base theme + images) that Drupal core
deprecated and made internal after dropping it as a public API. Install it so themes/modules that
still depend on jQuery UI keep working. jQuery UI is End-of-Life upstream — prefer migrating off it
for new code.

- **Type:** static asset-library provider. No routes (only `hook_help`), no permissions, no
  services, no config, no config schema, no plugins, no Drush.
- **Dependencies:** none declared (`core_version_requirement: ^9.2 || ^10 || ^11`). Libraries
  depend on `core/jquery` (and `core/drupal`, `core/drupalSettings` for `locale`).
- **Submodules shipped in this project:** none. The per-widget projects
  (`jquery_ui_accordion`, `jquery_ui_datepicker`, `jquery_ui_dialog`, `jquery_ui_effects`, …) are
  **separate** drupal.org projects; this base module *declares their libraries for them*.

## What it provides

Public base libraries in `jquery_ui.libraries.yml`:

- `jquery_ui/core` — the base (was `core/jquery.ui`)
- `jquery_ui/widget` — the widget factory (was `core/jquery.ui.widget`)
- `jquery_ui/mouse` — mouse interaction base
- `jquery_ui/position` — position utility
- `jquery_ui/locale` — datepicker localization (`js/locale.js`; depends on `core/drupal`,
  `core/drupalSettings`, `core/jquery`)

`jquery_ui.module` implements `hook_library_info_alter()`
(`jquery_ui_library_info_alter()`), which reads `jquery_ui.libraries.data.json` and injects the
real library definitions — the many `internal.*` sub-libraries for this module, and every widget/
effect library keyed under the companion module machine names — rewriting relative asset paths to
absolute. It also conditionally adds `jquery_ui/locale` + datepicker `drupalSettings` to the
`datepicker` library when `jquery_ui_datepicker` and core `locale` are both enabled.

## Attach a library

```php
$build['#attached']['library'][] = 'jquery_ui/core';
```

```yaml
# my_module.libraries.yml
my_module/my_lib:
  dependencies:
    - jquery_ui/core
    - jquery_ui/widget
```

Migration: replace old `core/jquery.ui*` references with the `jquery_ui/*` equivalents.

## Solution docs

- [Asset libraries & the dynamic declaration hook](libraries/asset-libraries.md)
