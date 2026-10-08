<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Block Content Type Visibility (block_content_type_visibility) — agent index

UX helper for Drupal core's block placement UI. It does **not** ship its own condition plugin: it reuses
core Node's built-in `entity_bundle:node` ("Content types") block-visibility condition and only alters the
block form to add friendly **Show/Hide** radios that map onto that condition's `negate` boolean.

- **Version:** 1.0.1 · **Core:** `^11` · **Package:** Block · **License:** GPL-2.0-or-later.
- **Dependencies:** `drupal:block`, `drupal:node`. No composer deps beyond core.
- **Provides:** no routes, no services, no permissions, no config schema, no condition/plugin type. Only a
  form alter + submit handler.

## What it actually does
- Implements `hook_form_block_form_alter` in the OOP Hook class
  `src/Hook/BlockContentTypeVisibilityHooks.php` (`#[Hook('form_block_form_alter')]`).
- When core's `visibility.entity_bundle:node` condition is present on the block form, it adds a
  `visibility_mode` radios element (`show` / `hide`), defaulting from the stored `negate` value, and sets
  the existing `negate` checkbox `#access => FALSE`.
- Adds `formBlockFormSubmit` which converts `visibility_mode` back to `negate` (`show`=0, `hide`=1),
  unsets `visibility_mode`, and writes it back into the `visibility` form value.
- `block_content_type_visibility.module` provides legacy procedural `*_form_block_form_alter` /
  `*_form_block_form_submit` that instantiate the Hook class and delegate — only when running on
  Drupal < 11.1 (or no `hook_collector` service). On 11.1+ the OOP class is used directly.

## Not access control
Block visibility only decides whether a block renders; it does not protect the block's underlying content.
No cache-context code here — core's Node condition owns bundle matching and cacheability.

## Solution docs
- [agent/config/block-visibility.md](config/block-visibility.md) — how the form alter works, stored config,
  install/enable, and how to operate it.
