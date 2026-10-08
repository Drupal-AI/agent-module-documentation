<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Autogrow Textarea (autogrow_textarea) — agent index

Auto-resizes every `<textarea>` to fit its content as the user types. Pure front-end UX; installed version **2.0.1**, version dir **2.0.x**. Core `^9 || ^10 || ^11`. Package: User Interface.

## What it is
A single-behavior JS module. `autogrow_textarea_element_info_alter()` in `autogrow_textarea.module` attaches the asset library `autogrow_textarea/autogrow_textarea` to core's `textarea` render element. The behavior `Drupal.behaviors.autogrow_textarea` (`js/autogrow_textarea.js`) sets each textarea's height to its `scrollHeight + 10px` on load and on every `input` event.

## Provides
- Hooks: `hook_element_info_alter` (one implementation).
- Asset library: `autogrow_textarea` (one JS file, `js/autogrow_textarea.js`).
- No routes, no permissions, no config/schema, no services, no plugins, no entities, no submodules, no Drush, no PHP dependencies beyond core.

## Dependencies
None outside Drupal core. `composer_requirements: {}`. (Library note: `libraries.yml` carries a `TODO` to declare `core/drupal` and `core/once` as JS deps; both globals are used but not formally declared — works because core loads them ambiently.)

## Operate / configure
Enable the module — no configuration exists. See:
- [agent/config/settings.md](config/settings.md) — install/enable, how the attach works, and why there is nothing to configure.
