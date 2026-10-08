<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# GraphQL Compose: Custom Field — agent index

Exposes Custom Field (`custom`) fields and their subfield columns through GraphQL Compose,
with per-column enable + rename (`name_sdl`). No field type/widget/admin page of its own;
config lives inside GraphQL Compose field settings.

- **The GraphQL plugins it registers, the `subfields` settings, and where they're stored** →
  [configure/graphql-subfields.md](configure/graphql-subfields.md)

Key facts:
- Depends on **`graphql_compose`** (the [GraphQL Compose](https://www.drupal.org/project/graphql_compose)
  project). **Not installable without it** — on a site lacking graphql_compose this submodule
  cannot be enabled.
- Registers GraphQL Compose **FieldType** plugins (base id `custom` + per-kind: date/time,
  date range, time range, entity reference, file, image, link, map, text, viewfield) and
  **SchemaType** plugins (Custom Field object type + link, URI, date range, time range,
  viewfield), plus a **SchemaExtension** for viewfield.
- Extends config schema `graphql_compose.field.*.*.*` with a `subfields` sequence
  (`custom_field_graphql.subfield.*` → `{enabled: bool, name_sdl: string}`), via
  `hook_config_schema_info_alter()`.
- Per-subfield form added by `hook_graphql_compose_field_type_form_alter()` (only for fields
  of type `custom`). Update hook `custom_field_graphql_update_10001` back-fills `subfields`.
