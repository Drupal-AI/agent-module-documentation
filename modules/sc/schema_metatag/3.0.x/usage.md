Schema.org Metatag is the base framework that lets the Metatag module output Schema.org structured data as JSON-LD, so search engines can render rich results (stars, prices, events, FAQs, breadcrumbs) for your content.

---

The module hooks into Metatag: it adds new Schema.org meta tags and groups on top of Metatag's normal tag definitions, then on `hook_page_attachments_alter()` it collects every schema tag on the page, parses the values into a nested structured-data array, and emits a single `<script type="application/ld+json">` block in the page head. Each Schema.org type (Article, Event, Product, …) is provided by a small companion submodule that registers a Metatag **Group** (the `@type`) plus one **Tag** plugin per Schema.org property, all extending the base classes `SchemaGroupBase` and `SchemaNameBase`. Property values are shaped by **PropertyType** plugins (`@SchemaPropertyType`), a plugin type this base module defines and manages via `plugin.manager.schema_property_type`; they turn tokenized field values into the right JSON-LD sub-structures (PostalAddress, ImageObject, Person, Duration, Rating, etc.). Because tags are configured through Metatag, values use tokens and can be set globally or per entity/bundle, and inherit Metatag's defaults and per-page overrides. The `SchemaMetatagManager` service handles parsing and JSON-LD encoding; `hook_metatag_tags_alter()` and `hook_schema_metatag_property_type_plugins_alter()` let developers retune any tag or property type. It provides no UI of its own — you enable the per-type submodules you need and configure them under Metatag. The result is standards-compliant structured data that is testable in Google's Rich Results Test.

---

- Add JSON-LD structured data to a Drupal site without hand-writing markup.
- Emit Schema.org `Article`/`BlogPosting` data for blog and news content.
- Produce `Product` markup with price, availability and rating for e-commerce.
- Mark up `Event` pages with dates, location, offers and performers.
- Generate `Recipe` rich snippets with ingredients, time and nutrition.
- Add `FAQPage`/`QAPage` structured data for question-and-answer content.
- Output `Organization` / `LocalBusiness` data for a company's site-wide identity.
- Add `Person` markup for author and staff profile pages.
- Provide `BreadcrumbList` structured data for search-result breadcrumbs.
- Configure schema tags globally, then override per content type or per node.
- Use tokens so structured-data values pull from entity fields automatically.
- Combine multiple Schema.org types on one page (e.g. Article + Organization).
- Validate output against Google's Rich Results Test / Schema.org validator.
- Add a brand-new Schema.org type by writing a small Group + Tag submodule.
- Reuse PropertyType plugins to render PostalAddress, GeoCoordinates or ImageObject sub-objects.
- Alter an existing tag's `@type` option tree via `hook_metatag_tags_alter()`.
- Swap the PropertyType plugin used by a property (e.g. Text instead of Place).
- Improve SEO / click-through with rich search-result snippets.
- Support decoupled front ends by exposing structured data in the rendered head.
- Keep structured data in sync with content edits automatically through Metatag.
- Provide `WebSite` markup enabling the sitelinks search box.
- Add `VideoObject` metadata for video pages.
- Export schema tag configuration between environments as Metatag config.
- Cache and reuse computed structured data via the module's cache bin.
