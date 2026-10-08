<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views Add Button — agent index

Adds a configurable "add an entity" button to Views, as a header/footer **area** or a **field**,
linking to an entity's create form with access-checking and token support. No configure route
(`configure: null`), no permissions, no Drush. Requires `views` + `token`.

Two Views handlers (registered by `hook_views_data_alter()` on the `views` table):

| Handler | Views id | Shown as |
|---|---|---|
| Area (header/footer) | `views_add_button_area` (field `views_add_button`) | "Global: Entity Add Button" |
| Field (per row) | `views_add_button_field` (field `views_add_button_field`) | "Entity Add Button" |

- **Add & configure the button in a view (all options, where stored)** →
  [configure/handlers.md](configure/handlers.md)
- **The `@ViewsAddButton` plugin type (URL/access per entity) + writing one** →
  [plugins/plugins.md](plugins/plugins.md)

Key facts:
- The target entity is stored as `type: "<entity_type>+<bundle>"` in the handler options.
- URL + create-access come from a `@ViewsAddButton` plugin chosen by `target_entity`: built-ins
  `views_add_button_node`, `_taxonomy`, `_user`, `_eck_entity`, and `_default` (fallback
  `/{entity_type}/add/{bundle}`).
- Every option except Entity Type supports tokens (`tokenize` uses first-row values).
