<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
AI JSON-LD Schema Generator uses the Drupal AI module to generate schema.org JSON-LD for content and URLs and attaches it to the page head.

---

AI JSON-LD Schema Generator adds schema.org structured data to a Drupal site without writing JSON by hand. Through the Drupal AI module (any configured chat provider) it generates valid JSON-LD from a node's content or from any internal path, and attaches one or more `<script type="application/ld+json">` blocks to the head of the matching page. Editors get a "Generate Schema via AI" button on enabled content types, a preview screen where they can review, edit, validate and regenerate the blocks, and a Google Rich Results Test link. URL/views-based schema is stored as "Schema mappings" in a custom `ai_schema_route` entity keyed by path. It also supports optional auto-generation on publish/update, site-wide Organization and WebSite schema set once in config, a configurable prompt template, token- or full-page content sourcing for nodes, and per-user rate limiting via Drupal's Flood API. It requires the AI module and depends on core node, field, user and views.

---

- Add Article/BlogPosting schema to editorial content automatically.
- Generate Event schema (date, location, performers) for webinars.
- Produce FAQPage schema from question/answer content.
- Emit BreadcrumbList schema from a page's breadcrumb trail.
- Output multiple schema.org types per page in a single `@graph`.
- Generate schema for a node with one click on its edit form.
- Preview and edit generated JSON-LD before saving it.
- Validate schema with the built-in Google Rich Results Test link.
- Create schema for any internal path (e.g. `/about`, `/services`).
- Generate schema for Views listing pages by their path.
- Store URL schema as reusable "Schema mappings" you can edit or delete.
- Auto-generate schema when a node is first published.
- Auto-regenerate schema when a node is updated.
- Define site-wide Organization and WebSite schema once in config.
- Use `[site:name]` / `[site:url]` tokens so schema works across environments.
- Send either a token-rendered snippet or the full rendered page to the AI.
- Customize the prompt template that drives generation.
- Pick which AI provider/model generates the schema (or use the site default).
- Rate-limit generations per user per hour to control AI cost.
- Improve eligibility for rich results and knowledge-panel data.
- Add Product, Service, HowTo, JobPosting or ItemList schema where the content fits.
- Keep JSON-LD in sync with content without maintaining it by hand.
