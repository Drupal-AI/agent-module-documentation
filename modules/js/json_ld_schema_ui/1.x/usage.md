<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
JSON-LD Schema UI adds a per-bundle UI for mapping entity data to schema.org types and emits the token-replaced result as a `<script type="application/ld+json">` block in the page `<head>` when the entity is rendered.

---

JSON-LD Schema UI (`json_ld_schema_ui`) lets site builders describe schema.org structured data for a content bundle entirely through the admin UI, then attach the resulting JSON-LD to rendered entities for SEO rich results. On a bundle's *Manage JSON LD schema* tab you pick one or more schema.org types (parsed from schema.org's published vocabulary), enable the properties you want, and set default values that may contain tokens (for example `[node:title]`). A `schema_content_settings` config entity stores that mapping per bundle, and the module automatically installs a hidden `jsonld` field (`jsonld_schema`) on every bundle that has a mapping. Each entity then carries a per-entity override widget so editors can override the allowed properties for that specific entity. At view time the field's computed `processed` property runs the configured/override values through Drupal's token system and JSON-encodes a `@context`/`@graph` schema.org document, and the `jsonld_head` formatter attaches it to the document head via `#attached[html_head]`, independent of the entity's themed output. It requires the contrib **Entity API** (`entity`) module; **Token** and **Select2** are optional enhancers. Administration is gated by the single `administer content schema settings` permission.

---

- Add schema.org JSON-LD structured data to nodes for search rich results without writing code.
- Map an Article bundle to the `Article` / `NewsArticle` schema type and default `headline` to `[node:title]`.
- Emit `Product` structured data (name, description, brand) from a commerce or catalog content type.
- Describe `Recipe` content with nested `nutrition`, `recipeIngredient`, and author `Person` properties.
- Output `Event` schema (startDate, location as a nested `Place`) from an events content type.
- Attach `Organization` or `LocalBusiness` markup to an "About" or contact page bundle.
- Configure `Movie` markup where the `actor` property references a nested `Person` type.
- Let editors override specific schema property values per entity while keeping site-wide defaults.
- Use entity tokens (`[node:...]`, `[node:author:...]`, field tokens) to populate schema values dynamically.
- Split a comma-separated token value into a JSON array by enabling "Allow multiple values" on a property.
- Configure more than one schema type per bundle (each becomes a node in the JSON-LD `@graph`).
- Add nested/reference properties (e.g. an actor's `birthDate`) through the "Add more properties" flow.
- Restrict which properties editors may override by toggling "Allow override" per property.
- Emit JSON-LD in the `<head>` so it survives regardless of the theme or view mode markup.
- Manage every bundle's schema mapping centrally alongside the per-bundle tabs.
- Apply structured data to any content-entity type that exposes a Field UI base route (nodes, taxonomy terms, media, custom blocks, etc.).
- Prefill per-entity override fields with the bundle's configured default values.
- Keep JSON-LD output cache-aware (the field's computed value carries cache tags/contexts from token replacement).
- Add structured data to improve appearance in Google/Bing rich results and knowledge panels.
- Pair with the Token module to get a token browser while entering default and override values.
- Optionally use Select2 for a friendlier schema-type picker on large vocabularies.
