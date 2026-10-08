<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Field Fetch (entity_field_fetch) — agent index

A **field type** that mirrors (fetches) a field value from *another* entity — a configured node,
term, or paragraph — onto the entity it is placed on, for centralized/shared content. Package
`Field types`. Core `^8 || ^9 || ^10 || ^11`. License GPL-2.0-or-later. Version 1.0.8.
**No module dependencies**, no permissions, no Drush, no settings route. Optional integrations:
`paragraphs` (fetch a paragraph), `graphql` (expose fetched data), `markdown` (render help page).

- **The field type, widget, formatter, field/widget settings, config schema, install/update** →
  [fields/field.md](fields/field.md)
- **The Fetcher service, computed `fetched` payload, GraphQL field, source-in-use delete
  protection, caching** → [api/services.md](api/services.md)

## What it provides (from source)

- **Field type** `entity_field_fetch` — `src/Plugin/Field/FieldType/EntityFieldFetchItem.php`
  (`@FieldType`, `default_widget = entity_field_fetch_widget`, `default_formatter =
  entity_field_fetch`). Stores only an unused tiny-int `value` column; all real values are
  **computed** properties (`target_type`, `target_id`, `target_field`, `fetched_bundle`,
  `fetched`; main property = `fetched`). `isEmpty()` always FALSE. Field settings:
  `target_entity_type`, `target_entity_id`, `field_to_fetch`, `target_paragraph_uuid`.
- **Widget** `entity_field_fetch_widget` — `.../FieldWidget/EntityFieldFetchWidget.php`. Renders a
  live preview of the source field/paragraph on the edit form; settings `show_field_label` (TRUE),
  `show_link_to_source` (FALSE), `show_source_updated_date` (FALSE).
- **Formatter** `entity_field_fetch` — `.../FieldFormatter/EntityFieldFetchFormatter.php`. Loads
  the configured source entity and renders the target field (or a paragraph via the paragraph
  view builder) on the host display.
- **Services** (`entity_field_fetch.services.yml`): `entity_field_fetch.fetcher`
  (`Service/Fetcher.php`), `entity_field_fetch.source_check` (`Service/SourceCheck.php`),
  `entity_field_fetch.delete_allow_check` (`Access/DeleteAllowCheck.php`, tagged access check
  `_eff_delete_allow_check`), `entity_field_fetch.route_subscriber` (`Routing/RouteSubscriber.php`).
- **GraphQL** field plugin `fetched` (`secure = true`) —
  `src/Plugin/GraphQL/Fields/Entity/Fields/EntityFieldFetch/EntityFieldFetchFetched.php` (only
  active with the `graphql`/`graphql_core` modules).
- **Config schema** `config/schema/entity_field_fetch.schema.yml` (field-settings +
  widget-settings mappings). No `config/install`, no permissions, no menu links.
- **Hooks** (`entity_field_fetch.module`): `hook_help` (renders README), `hook_entity_predelete`
  (blocks deleting an in-use source entity). Update `entity_field_fetch_update_8001`
  (`.install`) reworks legacy storage to fully computed fields.
