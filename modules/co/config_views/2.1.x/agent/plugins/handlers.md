<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views handlers & the entity-reference selection plugin

config_views ships these plugins (all under `src/Plugin`). You normally just *use* them from
a View; you rarely subclass them.

## Views query plugin

- **`views_config_entity_query`** (`Plugin/views/query/ConfigEntityQuery`) — extends core `Sql`
  but runs the Entity Query API. Set on a display as `query: { type: views_config_entity_query }`.
  It is selected automatically when you build a View on a `config_<type>` base table.

## Views field/filter handlers

- **`config_entity_operations`** (`Plugin/views/field/ConfigEntityOperations`) — renders the
  edit/delete **Operations** links for the listed config entity. Added to every config base
  table as the `operation` field.
- **`config_entity_boolean`** (`Plugin/views/filter/BooleanEntity`) — filter for schema
  `boolean` properties.
- **`config_entity_string`** (`Plugin/views/filter/StringEntity`) — filter for string
  properties.

(Field ids for the columns themselves are core handlers: `standard` for strings, `numeric`
for integers, `boolean` for booleans — see [../api/mechanism.md](../api/mechanism.md).)

## EntityReferenceSelection plugin — `config_views`

`Plugin/EntityReferenceSelection/ConfigViewsSelection` (id `config_views`, label **"Views:
Filter by a Configuration View"**, group `config_views`) extends core `ViewsSelection`. It
lets an **entity-reference field that targets a config entity type** use a config-entity View
(any display of type `entity_reference`) as its allowed-values source. The only behavioural
difference from core ViewsSelection is that it accepts config entity types (`instanceof
ConfigEntityTypeInterface`) when listing applicable views.

Config schema for its settings: `entity_reference_selection.config_views` (a `view` mapping
with `view_name`, `display_name`, `arguments`).

To use it: on the reference field's settings, choose reference method **Views: Filter by a
Configuration View**, then pick a config-entity View + display.

## The Views add-form grouping

`config_views_form_view_add_form_alter()` (in `config_views.module`) regroups the *Add view*
wizard's **Show** dropdown into **Content** and **Configuration** option groups and sorts them
by label — purely a UI nicety.
