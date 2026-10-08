<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Dialogs For All! (dialogs) — agent index

Tiny helper module that turns any internal link into a Drupal AJAX dialog / modal / off-canvas
trigger by adding magic `dialog` query-string parameters to the link. No UI, routes, permissions,
config schema, entities, or plugin types — it is driven entirely by the link query you author.

- **Core requirement:** `^8.7.7 || ^9 || ^10 || ^11`. No composer or module dependencies.
- **How it works:** implements `hook_link_alter()` (`dialogs.module` → `DialogsHooks::hookLinkAlter()`),
  which delegates to `DialogifyerFactory` / `Dialogifyer` in `src/`.
- **Services** (`dialogs.services.yml`):
  - `dialogs.dialogifyer_factory` → `Drupal\dialogs\DialogifyerFactory` (args: `@renderer`, `@library.discovery`).
  - `dialogs.hooks` → `Drupal\dialogs\DialogsHooks` (arg: `@dialogs.dialogifyer_factory`).
- **Trigger:** a `dialog` key in the link's `options['query']`. Recognised sub-keys: `type`
  (default `dialog`, or `modal`), `renderer` (e.g. `off_canvas`, `off_canvas_top`), `options`
  (jQuery UI dialog options, array or JSON string), `libraries` (array or `|`-delimited string of
  `extension/name`, validated via library discovery). All `dialog` params are stripped from the URL.
- **Attached libraries:** always `core/drupal.dialog.ajax`, plus any valid requested effect libraries.

Solution docs:
- [How the link rewrite works / query syntax](api/link-alter.md)
