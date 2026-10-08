<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
GraphQL Compose: Custom Field exposes Custom Field (`custom`) fields — and each of their subfield columns — through a GraphQL Compose schema, with per-column enable/rename control.

---

This submodule bridges the Custom Field module and [GraphQL Compose](https://www.drupal.org/project/graphql_compose). It registers a set of GraphQL Compose **FieldType** plugins (the base `custom` type plus per-data-kind types for date/time, date range, time range, entity reference, file, image, link, map, text and viewfield columns) and matching **SchemaType** plugins that define the GraphQL object types produced for a Custom Field and its structured columns (link, URI, date range, time range, viewfield). It extends GraphQL Compose's field settings config schema (`graphql_compose.field.*.*.*`) with a `subfields` sequence so each column can be individually **enabled** and given a GraphQL **schema field name** (`name_sdl`) — useful because Custom Field column machine names often contain underscores that are not ideal SDL identifiers. A `hook_graphql_compose_field_type_form_alter()` implementation adds the per-subfield UI to the GraphQL Compose field form, and an update hook (`custom_field_graphql_update_10001`) back-fills `subfields` settings for existing custom fields. A GraphQL SchemaExtension wires up the viewfield column type. It defines no field type, widget, or admin page of its own; all configuration happens inside GraphQL Compose's field settings.

---

- Expose a Custom Field and its columns in a decoupled/headless GraphQL API via GraphQL Compose.
- Return a compound "spec" Custom Field (title, price, date) as a structured GraphQL object type.
- Enable only selected columns of a Custom Field in the GraphQL schema, hiding the rest.
- Rename a column with an underscore machine name to a clean camelCase GraphQL field via `name_sdl`.
- Serve a Custom Field `link` column as a proper GraphQL Link object type.
- Serve a `datetime` / `daterange` / `time_range` column with dedicated GraphQL date/time types.
- Expose an `entity_reference` column as a resolved GraphQL entity in the schema.
- Expose a `file` or `image` column with its GraphQL file/image type.
- Expose a `viewfield` column (from custom_field_viewfield) through the schema extension.
- Serve a `map` column as a GraphQL map/JSON type.
- Build a Next.js/Nuxt front end that queries Custom Field data over GraphQL.
- Keep GraphQL schema field names stable while changing internal Custom Field column names.
- Back-fill GraphQL subfield settings for pre-existing custom fields with the update hook.
- Provide a consistent GraphQL representation across many bundles that share a Custom Field.
- Disable a sensitive Custom Field column from the public GraphQL schema while keeping it in Drupal.
- Combine with GraphQL Compose entity types to nest Custom Field objects inside node queries.
- Document a Custom Field's GraphQL shape for front-end developers via the generated SDL.
- Expose URI columns as GraphQL URI object types with resolved paths.
- Map Custom Field text columns (including `string_long`) to GraphQL string fields.
- Migrate a Paragraphs-based GraphQL schema to the flatter Custom Field representation.
