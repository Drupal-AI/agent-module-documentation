# JSON LD Schema API — agent index

Developer-only API to emit Schema.org JSON-LD `<script type="application/ld+json">` tags. No UI,
no config, no permissions, no Drush. Requires the `spatie/schema-org` PHP library (a `Type` builder).
You add structured data exclusively by writing plugins.

- **The two plugin types (`JsonLdSource` = site-wide, `JsonLdEntity` = per-entity), how they are
  discovered, rendered, cached, and altered** → [plugins/json_ld_schema.md](plugins/json_ld_schema.md)

Key facts:
- `hook_page_bottom()` renders every `JsonLdSource` where `isApplicable()` is TRUE (default: every page).
- `hook_entity_view()` attaches every applicable `JsonLdEntity` to `html_head`.
- Both `getData()` return a `\Spatie\SchemaOrg\Type`; `JsonLdSchemaUtil::encodeJsonLdData()` serializes it
  with hex-escaping flags safe for `<script>`.
- No `.permissions.yml`, no `config/`, no `configure` route. Alter hooks: `json_ld_source_info_alter`,
  `json_ld_entity_info_alter`.
