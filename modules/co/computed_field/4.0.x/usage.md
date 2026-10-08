Computed Field adds read-only fields to entities whose values are generated dynamically by code (a "computed field plugin") rather than stored in the database. Computed fields reuse core field types and their existing formatters, so their output displays like any normal field.

---

The module defines a `computed_field` plugin type: each plugin declares a core field type (`string`, `entity_reference`, `integer`, …) and implements `computeValue()` to return the field's value(s) from arbitrary logic. Plugins come in two flavours. **Automatically attached** plugins declare in their attribute which entity types/bundles they attach to (as base or bundle fields) and appear with no configuration. **Configured attaching** plugins are added by a site admin, which creates a `computed_field` config entity (id `entity_type.bundle.field_name`) holding the plugin id and its `plugin_config`; these plugins may be configurable by implementing `ConfigurableInterface` + `PluginFormInterface`. The optional **Computed Field UI** submodule adds an "Add computed field" action to the Field UI so admins can create these config entities without code. Because a computed field's value can be dynamic or depend on things other than the host entity, plugins can opt into a lazy builder and declare custom cacheability. The module ships one ready-to-use plugin, `reverse_entity_reference` (an `entity_reference` field listing entities that reference the host). Computed fields are read-only (no widget, no stored data) and reuse core field formatters for display.

---

- Show a live-calculated value on an entity (e.g. a node) without storing it in the database.
- Display the number of comments, children, or related items for an entity, recomputed on every view.
- Add a "reverse entity reference" field that lists all entities pointing at the current one (via the bundled `reverse_entity_reference` plugin).
- List all nodes authored by a user directly on the user entity.
- Compute a full name from separate first/last name fields for display.
- Derive a formatted price, total, or tax from other stored fields.
- Surface a value pulled from a remote API or another service as if it were a field.
- Show the current request time, current user, or other request-context data as a field.
- Expose a value that depends on the viewing user, using per-field cacheability and a lazy builder.
- Add a computed base field to every bundle of an entity type in code (automatic base-field plugin).
- Add a computed bundle field to specific bundles in code (automatic bundle-field plugin).
- Attach computed fields dynamically based on runtime conditions (dynamic attach logic).
- Let site builders add computed fields through the Field UI with the Computed Field UI submodule.
- Reuse existing field formatters (link, entity reference label, number, date) for a computed value.
- Provide a configurable computed field whose behaviour an admin tunes via a plugin form.
- Build a "related content" block of back-references without writing a View.
- Present aggregated or summarised data (counts, sums, concatenations) as a first-class field.
- Replace ad-hoc `hook_entity_view()` / preprocess markup with a proper, formatter-driven field.
- Add multi-value computed fields (cardinality > 1) that return several deltas.
- Expose computed values to entity displays, so they can be positioned in Manage Display.
- Migrate legacy "computed field" (D7-style PHP snippet) fields to plugin-based computed fields.
- Alter or replace another module's computed field plugin definition via `hook_computed_field_info_alter()`.
- Hide an automatically attached plugin from the admin UI with the `no_ui` attribute property.
- Provide fields whose value is derived from the entity's own other fields at render time.

