<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Browser Block Layout (entity_browser_block_layout) — agent index

UX/CSS glue that makes **Entity Browser Block** blocks easier to place in **Layout Builder**.
It is **all form-alter hooks + one service class** — no routes, no permissions, no block plugins,
no controllers of its own. Version **1.1.x** (release 1.1.0). Core `^10.3 || ^11.0`. License
GPL-2.0-or-later.

- **Dependency:** composer `drupal/entity_browser_block` (`^1.0 || ^2.0`), i.e. module
  `entity_browser_block`. Functionally also needs core **Layout Builder** and contrib
  **Entity Browser** (per README); neither is declared in `.info.yml`.
- **No** `configure` route, `.permissions.yml`, `.routing.yml` or `.services.yml`.

## What it actually is

- One class, `Drupal\entity_browser_block_layout\FormAlter` (`src/FormAlter.php`), a
  `ContainerInjectionInterface` resolved via `\Drupal::classResolver()` from the hooks in
  `entity_browser_block_layout.module`. Injects `entity_display.repository`,
  `entity_type.manager`, `redirect.destination`, `renderer`, `string_translation`.
- Hooks (all `hook_form_FORM_ID_alter` / preprocess, in the `.module`):
  `layout_builder_add_block`, `layout_builder_update_block`, `node_type_add/edit_form`,
  `media_type_add/edit_form`, `views_exposed_form`, and `hook_preprocess_views_view`.
- Config: **schema only** (`config/schema/entity_browser_block_layout.schema.yml`) for the
  bundle third-party setting; four **optional** Entity Browser views in `config/optional/`
  (`node_browser`, `block_browser`, `media_entity_browser`, `bio_browser`).
- Two internal libraries (`entity_browser_block_layout.libraries.yml`): `eb_layout_panel`
  (sidebar CSS) and `eb_view_decoration` (CSS + `js/eb_view_decoration.js`). No external libs.

## Solution docs

- **Layout Builder add/update-block integration** (the sidebar tweaks, Edit button,
  view-mode filtering, auto-open modal) → [forms/layout-builder-integration.md](forms/layout-builder-integration.md)
- **Per-bundle allowed view modes** (node/media type third-party setting + schema) →
  [config/view-modes.md](config/view-modes.md)
