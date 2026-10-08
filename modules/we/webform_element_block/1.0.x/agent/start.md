<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webform Element Block (webform_element_block) — agent index
**Provides one Webform element that renders a Drupal block plugin inline as markup inside a form.**

- **Version:** 1.0.x (release 1.0.2)
- **Core:** ^10 || ^11
- **Dependencies:** webform
- **Project vs module:** project machine name `webform_block_element`; shipped module machine name `webform_element_block`.
- **Element:** plugin id `webform_block_element`, label "Webform Block Element", category "Custom" — `src/Plugin/WebformElement/WebformBlockElement.php`, extends `Drupal\webform\Plugin\WebformElement\WebformMarkup`.
- **How it works:** element property `#block_id` (Block ID text field) holds a block plugin machine name; `prepare()` does `blockManager->createInstance(#block_id)->build()`, renders it, and sets `#markup`. Display-only (no submitted value).
- **No** config page, permissions, Drush commands, config schema, routes, or submodules.
- Note: `src/CpVnaWaterService.php` is unrelated leftover code (namespace `cp_vna_suez_water_service`, references a missing `cp_api` module); it is not wired into this module and provides no capability.

See [plugins/element.md](plugins/element.md)
