<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Canvas Page Metatag (canvas_page_metatag) — agent index

Re-exposes the Metatag SEO tag groups that Drupal Canvas hides on its `canvas_page`
edit form. Pure Form API integration — no rendering, no entities, no custom plugins.
Metatag itself emits the saved tags into the page `<head>`.

## What it provides
- Hook service `Drupal\canvas_page_metatag\Hook\CanvasPageMetatagFormHooks`
  (`#[Hook('form_canvas_page_form_alter')]`) — toggles `#access` on the Basic,
  Advanced, Open Graph, Facebook, and Twitter Cards groups per config, and attaches
  a repair callback to Metatag's Robots checkboxes.
- Settings form `Drupal\canvas_page_metatag\Form\SettingsForm` at route
  `canvas_page_metatag.settings` (`/admin/config/search/canvas-page-metatag`,
  requires `administer site configuration`).
- Config object `canvas_page_metatag.settings` (5 booleans) + schema.

## Dependencies
Requires (via composer + info.yml): `canvas` (Drupal Canvas ^1.8), `metatag` (^2.2),
and Metatag submodules `metatag_open_graph`, `metatag_facebook`, `metatag_twitter_cards`.
Core `^10.3 || ^11.1`. No PHP constraint, no libraries, no permissions, no Drush, no submodules.

## Routes & links
- `canvas_page_metatag.settings` — the settings form (menu link under
  `system.admin_config_search`).

## Solution docs
- [agent/config/settings.md](config/settings.md) — settings config object, keys, defaults, route/permission.
- [agent/api/form-alter.md](api/form-alter.md) — the form-alter hook, `#access` logic, and the Robots checkboxes repair.
