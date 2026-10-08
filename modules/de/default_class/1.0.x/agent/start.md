<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Default Class (default_class) — agent index

Zero-configuration theming helper. Adds descriptive CSS classes to rendered
markup (blocks and canonical entity pages) using data Drupal already has. No
settings, routes, permissions, services, plugins, config, or Drush commands.

- **Dependencies:** Drupal core only (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`). No contrib deps, no composer requirements, no libraries.
- **Provides:** two preprocess hooks in `default_class.module`:
  - `default_class_preprocess_block()` — adds `block`, normalized `plugin_id`, `provider`, `block--<region>`, and `block--block-content--<bundle>` classes to block markup.
  - `default_class_preprocess_html()` — on node/user/taxonomy_term canonical pages, adds `node-<id>`/`node-<bundle>`, `user-<uid>`/`user-<name>`, and `term-<tid>`/`term-name-<label>`/`term-vid-<vocab>` classes to the page/body element.
  - `default_class_help()` — help text at `help.page.default_class`.
- **Entities/plugins/routes/services:** none.
- **Configuration:** none — enabling the module is the whole setup.

Solution docs:
- [Classes added and how they render](theming/classes.md)
