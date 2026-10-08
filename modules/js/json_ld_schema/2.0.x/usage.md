JSON LD Schema API is a developer-only, code-first module for emitting Schema.org structured data as JSON-LD `<script type="application/ld+json">` tags. It ships no UI, config, or permissions — you add structured data by writing plugins.

---

The module defines two plugin types, both discovered from `src/Plugin/…`. A **JsonLdSource** plugin (`Plugin/JsonLdSource`, `@JsonLdSource` annotation) emits site-wide JSON-LD: `hook_page_bottom()` iterates every source, calls `isApplicable()` (default `TRUE` = every page), and renders its `getData()` into a `json_ld_source` render element cached by render cache. A **JsonLdEntity** plugin (`Plugin/JsonLdEntity`, `@JsonLdEntity` annotation) emits per-entity JSON-LD: `hook_entity_view()` iterates every entity plugin, calls `isApplicable($entity, $view_mode)`, and attaches a `<script>` to `html_head`, merging the plugin's cacheable metadata into the entity build. Both plugins return a `\Spatie\SchemaOrg\Type` object (from the required `spatie/schema-org` library) that fluently builds the Schema.org graph; `JsonLdSchemaUtil::encodeJsonLdData()` serializes it with `JSON_HEX_TAG|JSON_HEX_APOS|JSON_HEX_AMP|JSON_HEX_QUOT` so the payload is safe to embed in a `<script>`. Base classes `JsonLdSourceBase` and `JsonLdEntityBase` provide sane defaults plus helpers (`absoluteUriString()`, `formatTimestamp()`). Cacheability is first-class: sources expose `getCacheableMetadata()` and expensive work runs in a `#pre_render` callback so it is cached; entity plugins fold their cache tags/contexts into the host entity's render cache. There is no config entity, settings form, or Drush command — everything is defined in PHP by module developers.

---

- Emit `Organization` / `WebSite` JSON-LD on every page via a `JsonLdSource` plugin.
- Add `Article` or `NewsArticle` structured data to node pages via a `JsonLdEntity` plugin.
- Output `BreadcrumbList` structured data for rich breadcrumb results.
- Add `Product` + `Offer` markup to commerce product entities for rich shopping results.
- Emit `FAQPage` structured data from a paragraph or field on a node.
- Provide `Recipe` structured data (ingredients, cook time) for recipe content types.
- Add `Event` structured data (start/end date, location) to event entities.
- Restrict a source to certain pages by overriding `isApplicable()` (e.g. front page only).
- Restrict entity markup to a specific entity type / bundle / view mode in `isApplicable()`.
- Attach `LocalBusiness` markup with address and opening hours site-wide.
- Build the Schema.org graph fluently with the `spatie/schema-org` `Type` API instead of hand-writing JSON.
- Ensure JSON-LD is safely escaped for `<script>` embedding via `JsonLdSchemaUtil::encodeJsonLdData()`.
- Integrate structured data with Drupal render cache so expensive lookups run once (via `#pre_render`).
- Add correct cache tags/contexts so JSON-LD invalidates when the underlying entity changes.
- Convert an internal URI to an absolute URL for `@id`/`url` fields using `absoluteUriString()`.
- Format a timestamp as ISO-8601 for `datePublished`/`dateModified` using `formatTimestamp()`.
- Alter or add third-party source/entity plugin definitions via `hook_json_ld_source_info_alter()` / `hook_json_ld_entity_info_alter()`.
- Provide `Person` author markup derived from a node's author field.
- Emit `VideoObject` structured data for media entities.
- Add `SearchAction` (sitelinks search box) markup via a site-wide source.
- Keep structured-data logic in version-controlled code rather than clickable admin config.
