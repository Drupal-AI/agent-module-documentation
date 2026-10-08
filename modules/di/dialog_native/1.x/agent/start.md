<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Dialog Native (dialog_native) — agent index

Front-end / developer module that replaces Drupal core's jQuery UI–based dialog
(`core/drupal.dialog`, `core/drupal.dialog.ajax`) with reimplementations built on
the native HTML `<dialog>` element. No admin UI, config, routes, permissions, PHP
services, or plugins. Heavy WIP; not production ready. Targets core `^10 || ^11`.

## What it provides
- `hook_library_info_alter()` in `dialog_native.module` — unsets core
  `drupal.dialog` and `drupal.dialog.ajax`, then repoints them at this module's
  `dialog_native/dialogNative` and `dialog_native/dialogNativeAjax` libraries.
- Two Drupal libraries (`dialog_native.libraries.yml`):
  - `dialogNative` — `dist/dialogTheme.js`, `dist/dialog.js`, `css/dialogNative.css`;
    depends on `core/drupal`, `core/drupal.displace`, `core/internal.floating-ui`.
  - `dialogNativeAjax` — `dist/dialogAjax.js`; depends on `core/jquery`,
    `core/drupal`, `core/drupalSettings`, `core/drupal.ajax`, `core/drupal.dialog`.
- Overrides `Drupal.dialog()`, `Drupal.AjaxCommands.prototype.openDialog` /
  `closeDialog`, and the `Drupal.theme.dialog*` theme functions.
- TypeScript sources in `src/`; shipped/compiled assets in `dist/`.

## Dependencies
Drupal module deps: none. Front-end deps: `@floating-ui/dom` (via
`core/internal.floating-ui`), `core/drupal.displace`, and (for the AJAX adapter)
`core/jquery` + `core/drupal.ajax`.

## Solution docs
- [Library override & architecture](libraries/override.md) — how the swap works,
  the library graph, lifecycle events, options, and theme functions.
