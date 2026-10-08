<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Menu Entity Index — agent index

Maintains a `menu_entity_index` DB table mapping tracked **menu links → referenced entities**.
Depends on core `menu_link_content`. You pick which menus + entity types to track; the module
then keeps the index current and exposes it via an edit-form pseudo-field and Views.

- **Configure tracking (settings form, config keys, permissions, edit-form widget)** →
  [configure/tracking.md](configure/tracking.md)
- **Rebuild the index from Drush** → [drush/rebuild-index.md](drush/rebuild-index.md)
- **Tracker service, the index table, and Views integration** → [api/tracker.md](api/tracker.md)

Key facts:
- Config object: `menu_entity_index.configuration` → keys `menus` (seq), `entity_types` (seq),
  `all_menus` (bool). Configure route `menu_entity_index.configure` at
  `/admin/config/search/menu_entity_index`.
- Service: `menu_entity_index.tracker` (`Drupal\menu_entity_index\Tracker`).
- Drush: `menu-entity-index:rebuild-index` (alias `mei-r`).
- No field types, no plugin managers, no templates.
