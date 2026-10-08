<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Structured Data Generator adds JSON-LD Schema.org markup to the page `<head>` for improved SEO / rich results, through an extensible plugin system.

---

The module defines a `StructuredDataGenerator` plugin type (interface `StructuredDataGeneratorInterface`, `getStucturedData()` returning a Spatie `BaseType` or null). On `hook_page_attachments()` the `structured_data_generator.attachments` service instantiates every plugin, skips any disabled in config, and emits each result as a `<script type="application/ld+json">` element via `json_encode(...)`. It ships one plugin, `breadcrumb_sdg` (BreadcrumbPlugin), which converts the site's breadcrumb trail into a Schema.org `BreadcrumbList`. Which plugins run is controlled at `/admin/config/development/structured_data_generator` (`administer structured_data_generator`, restricted). The Spatie `spatie/schema-org` library is a Composer dependency.

Custom structured data is added by shipping a plugin class in `src/Plugin/StructuredDataGenerator/` with the `@StructuredDataGenerator` annotation. The only route is the admin settings form; there are no mutating or anonymous endpoints. Typical setup: enable the module and toggle plugins in settings; extend by writing generator plugins.

---

- Emit JSON-LD structured data into the page head automatically.
- Add Schema.org `BreadcrumbList` markup from the site breadcrumb trail.
- Improve eligibility for search-engine rich results / breadcrumbs.
- Enable or disable individual generator plugins in settings.
- Write a custom generator for `Organization` schema.
- Write a custom generator for `Article` / `Product` / `FAQPage` schema.
- Return `null` from a generator to suppress output on some routes.
- Use the bundled `spatie/schema-org` fluent builder to construct types.
- Register a generator via the `@StructuredDataGenerator` annotation.
- Alter discovered plugins with `hook_structured_data_generator_info`.
- Validate emitted JSON-LD with Google's Rich Results Test.
- Restrict settings access to the `administer structured_data_generator` role.
- Attach schema conditionally per current route in a plugin.
- Combine multiple generators, each emitting its own `<script>` tag.
- Cache plugin definitions (handled by the plugin manager) for performance.
- Extend a module's SEO output without editing templates.
