<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DrupalOrg test content (drupalorg_test_content) — agent index

Submodule of **Drupal.org** (`drupalorg`). Ships exported **default content** to seed a local/dev site — no PHP, no routes, no services, no config. Package `DrupalOrg`. Core `^9 || ^10 || ^11`. GPL-2.0-or-later. Version 1.0.0.

- **Dependency**: `default_content:default_content` (imports the exports on enable).
- **Parent**: [../../../../start.md](../../../../start.md) (`drupalorg`).
- **What it contains + how to load it** → [content/default-content.md](content/default-content.md).

Enable with `drush en drupalorg_test_content -y`. Intended for local/development installations only, not production.
