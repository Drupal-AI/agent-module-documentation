<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views filter: "Limit to unreferenced entities"

## What it is

A Views filter plugin that restricts a view to entities **not referenced** by anything Entity
Usage tracks — i.e. content nothing links to or embeds. Useful for finding never-used media/nodes
that can be cleaned up.

- Plugin id: **`entity_usage_plus_unreferenced`**
- Class: `Drupal\entity_usage_plus\Plugin\views\filter\EntityUnreferenced`
  (`src/Plugin/views/filter/EntityUnreferenced.php`), extends `FilterPluginBase`, declared with
  `#[ViewsFilter("entity_usage_plus_unreferenced")]`.
- Config schema: `views.filter.entity_usage_plus_unreferenced` (`type: views_filter`) in
  `config/schema/entity_usage_plus.views.schema.yml`.

## How it is registered

`EntityUsagePlusHooks::viewsDataAlter()` (`hook_views_data_alter`, in
`src/Hook/EntityUsagePlusHooks.php`) adds a `entity_usage_plus_unreferenced` filter definition to
the Views data of **each entity type that**:
1. is in `entity_usage.settings:track_enabled_target_entity_types` (if that list is set), **and**
2. has a `views_data` handler.

The filter is attached with `'field' => 'id'` on the entity's base Views table, titled
*"Limit to unreferenced entities"*.

## How the query works

`EntityUnreferenced::query()`:
- resolves the entity type id (`$type_id`) and id key (`$type_key`) from the entity type
  definition;
- builds a subquery: `SELECT target_id FROM entity_usage WHERE target_type = :type_id GROUP BY
  target_id`;
- adds `WHERE {base_table}.{id_key} NOT IN (subquery)` (where-group `1`, `AND`).

Everything fed into the query is derived from entity-type metadata and the Views base table via
the database API's `select()`/`addWhere()` (parameterised subquery), not from request input.

Behavioral notes from the source comments:
- If content is referenced by **any** revision (even an old one no longer using it), it counts as
  referenced and is excluded.
- Inline blocks persist after removal from a page, so anything referenced by an inline block also
  counts as referenced.

## UI behavior

- `canExpose()` returns **FALSE** — the filter **cannot be exposed** to site visitors; it is a
  fixed, admin-configured filter only.
- `operatorForm()` and `adminSummary()` are empty (no operator, no value): adding the filter to a
  view is the whole configuration.

## Using it

1. Ensure Entity Usage tracks the source/target types you care about and its bulk update has run.
2. Create a view whose base entity type is Entity-Usage-tracked (e.g. Media, Content).
3. Add filter criterion **"Limit to unreferenced entities"** — no further options.
4. The view now lists only entities with zero recorded usage. Results are only as complete as the
   `entity_usage` table.
