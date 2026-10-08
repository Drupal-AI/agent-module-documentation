<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Preview (all_entity_preview / machine `preview`) — agent index

Core-node-style "preview before saving" generalized to any content entity type/bundle. Adds a
Preview button, a `/preview/...` render route, and view-mode switching. `configure` =
`preview.settings`. No module permissions (admin form uses `administer site configuration`); no Drush.

- **Enable entity types/bundles + default view mode (config `preview.settings`)** →
  [configure/settings.md](configure/settings.md)
- **Access model, param converter, controller, and the `preview.back_link` event** →
  [api/access-and-events.md](api/access-and-events.md)

Key facts:
- Project `all_entity_preview`, **module machine name `preview`** (all identifiers are `preview.*`).
- Route `preview.entity_preview` → `/preview/{entity_preview}/{view_mode_id}`
  (`PreviewController::view`, access `_entity_preview_access`).
- Settings route `preview.settings` → `/admin/config/content/preview` (`administer site configuration`).
- Config `preview.settings`: `enabled[<entity_type>][<bundle>] = <default_view_mode>`.
- Preview state stored in **private per-user tempstore** (`entity_preview`, keyed by entity UUID);
  param converter `entity_preview` rehydrates the unsaved entity from it.
- Hooks implemented in `src/Hook/PreviewHooks.php` (`form_alter`, `page_top`, `help`).
- **Security reviewed:** access requires create/update on the entity + private tempstore → no
  finding (no `security.md`). See the access doc for the reasoning.
