Typed Data extends Drupal core's Typed Data API with a data fetcher (property-path navigation), a placeholder/token resolver with filters, and pluggable form widgets for building and editing typed data values.

---

Typed Data is a developer toolkit that fills gaps in core's Typed Data API and is a foundation for modules like Rules. Its `typed_data.data_fetcher` service walks a property path (e.g. `node.uid.entity.name.value`) to fetch a nested value or its data definition, and can autocomplete partial paths. Its `typed_data.placeholder_resolver` service scans text for `{{ ... }}` placeholders and replaces them with fetched values, passing each through optional filters. The module defines two new plugin types: **DataFilter** (`typed_data_filter`) for transforming resolved values — shipping `lower`, `upper`, `trim`, `strip_tags`, `count`, `format_date`, `format_text`, `replace`, `entity_url`, and a default fallback — and **TypedDataFormWidget** (`typed_data_form_widget`) for rendering an edit form for a given data type (text input, textarea, select, datetime, datetime range). Both plugin types support annotations and PHP attributes for discovery. A set of Drush commands lists the available entities, contexts, data types, filters, and widgets to aid development and debugging. It ships no UI, permissions, or config of its own — it is purely programmatic infrastructure that other modules build on.

---

- Fetch a nested value by property path (`node.uid.entity.name.value`) in code.
- Resolve `{{ node.title.value }}`-style placeholders in a text template.
- Apply filters to placeholders, e.g. `{{ node.title.value | upper }}`.
- Truncate or format resolved dates with the `format_date` filter.
- Strip HTML tags from a resolved value with `strip_tags`.
- Count items in a list value with the `count` filter.
- Build a link from an entity with the `entity_url` filter.
- Autocomplete property paths in an admin UI (e.g. a token-path field).
- Fetch a data *definition* by path to validate a configured path.
- Provide the data layer that the Rules module builds conditions/actions on.
- Define a custom DataFilter plugin to add a new placeholder transformation.
- Define a custom TypedDataFormWidget to edit a bespoke data type in a form.
- Render an edit widget (text, textarea, select, datetime) for a typed data value.
- Let site builders enter token-like expressions that resolve at runtime.
- Build a mapping UI that reads and writes arbitrary entity properties.
- Debug available data types with `drush typed-data:datatypes`.
- List all available entities with `drush typed-data:entities`.
- Inspect registered contexts with `drush typed-data:contexts`.
- Enumerate registered data filters with `drush typed-data:datafilters`.
- Enumerate form widgets with `drush typed-data:formwidgets`.
- Collect cacheability metadata (bubbleable) while resolving placeholders.
- Support multilingual value fetching by passing a langcode.
- Provide a reusable placeholder engine for custom notification/email bodies.
- Transform user-entered text safely with `format_text` before display.
- Power dynamic default values in configuration forms via property paths.
