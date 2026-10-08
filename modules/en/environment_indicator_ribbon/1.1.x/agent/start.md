<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Environment indicator ribbon (environment_indicator_ribbon) — agent index

A thin visual add-on to **`environment_indicator`**. It draws a **diagonal corner ribbon**,
fixed to the bottom-left of the viewport, naming the current environment (dev / stage / prod),
reusing environment_indicator's configured name and colours. It defines **no settings form, config
object, config schema, route, service, entity, plugin type, or Drush command of its own**.

- Version **1.1.x** (release 1.1.0, stable); core `^9 || ^10 || ^11`.
- Hard dependency: `drupal/environment_indicator: ^4` (module `environment_indicator`).
- The whole module is **one hook** (`hook_page_attachments()`) + **one asset library** (1 CSS, 1 JS).
- Provides **one permission**: `access environment indicator ribbon`.
- `configure` in `.info.yml` points at the base module's `environment_indicator.settings` route.

## Solution docs

- [reference/mechanism.md](reference/mechanism.md) — exact rendering path: the page-attachments
  hook, the drupalSettings payload, and the library's JS/CSS that draw the ribbon.
- [config/settings.md](config/settings.md) — where name/colours come from, per-environment setup,
  the permission gate, and troubleshooting.
