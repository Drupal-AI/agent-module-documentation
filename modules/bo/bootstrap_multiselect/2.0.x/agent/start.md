<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bootstrap Multiselect (bootstrap_multiselect) — agent index

Thin integration module for David Stutz's **bootstrap-multiselect** jQuery plugin (v1.1.1), which
renders a `<select multiple>` as a Bootstrap dropdown of checkboxes. Version **2.0.3**, core
`^9 || ^10 || ^11`. License GPL-2.0-or-later. Package "Other".

## What it actually provides
- **One asset library**, `bootstrap_multiselect/multiselect` (defined in
  `bootstrap_multiselect.libraries.yml`): bootstrap-multiselect 1.1.1 CSS + JS, depends on
  `core/jquery` and `core/drupal`. JS loads with `defer`.
- **One hook**, `bootstrap_multiselect_library_info_alter()` (in `bootstrap_multiselect.module`):
  swaps the CDN URLs for local files under `/libraries/bootstrap_multiselect/...` when present.

## What it does NOT provide
No form element, no field widget, no FormElement/FieldWidget plugin, no config or config schema,
no route, no permission, no service, no Drush command, no `src/` directory, no submodules. It does
not initialise the plugin on any element — the consuming theme/module attaches the library and calls
`$el.multiselect()` itself.

## Dependencies
Drupal core only (`drupal/core: ^9 || ^10 || ^11`). No contrib module dependencies.

## Solution docs
- [Library, CDN-vs-local override, and usage](library/multiselect.md)
