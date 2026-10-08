# JSON LD Schema API — manual setup guide

**JSON LD Schema API** (`json_ld_schema`) is a **developer‑focused, code‑first**
module for adding Schema.org structured data to your site as JSON‑LD
`<script type="application/ld+json">` tags. Structured data helps search engines
understand your content and can produce rich results (article cards, breadcrumbs,
product offers, FAQs, recipes, events, and so on).

This is important to understand up front: the module ships **no admin UI, no
settings form, and no permissions**. You don't configure structured data by
clicking around — you add it by **writing plugins in PHP**. That keeps your
structured‑data logic in version‑controlled code rather than clickable config, which
is exactly the point of this "opinionated, developer‑centric API" module. If you
want a click‑to‑configure Schema.org experience, this is not that module.

There are two kinds of plugin you write:

- **JsonLdSource** — emits **site‑wide** JSON‑LD. The module renders every source on
  every page (unless you scope it), so it's ideal for `Organization`, `WebSite`,
  `LocalBusiness`, or a sitelinks `SearchAction`.
- **JsonLdEntity** — emits **per‑entity** JSON‑LD. The module attaches it when a
  matching entity is viewed, so it's ideal for `Article`/`NewsArticle` on nodes,
  `Product` + `Offer` on commerce products, `Recipe`, `Event`, `BreadcrumbList`, and
  the like.

Both plugin types build their data with the **`spatie/schema-org`** PHP library's
fluent `Type` builder (so you don't hand‑write JSON), and the module serializes it
safely for embedding in a `<script>` tag. Cacheability is first‑class: expensive
source lookups run in a pre‑render callback and are cached, and entity plugins fold
their cache tags/contexts into the host entity's render cache so the JSON‑LD
invalidates correctly when the underlying content changes.

This guide is written for a **human** developer. If you want terse, token‑cheap
references for an AI coding agent — including plugin interfaces and copy‑paste
examples — read the sibling [`agent/`](../agent/start.md) docs, which go into the
plugin code in detail.

## Contents

1. [Installation](installation/index.md) — install with Composer (including the
   required `spatie/schema-org` library) and enable the module.

## Where it lives in the admin menu

Nowhere — there is no admin page, no configuration entity, and no `configure`
route. Everything is defined in code.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. In your own custom module, create a plugin:
   - For site‑wide data, add a class under `src/Plugin/JsonLdSource/` annotated with
     `@JsonLdSource`, implementing `getData()` (return a `spatie/schema-org` `Type`)
     and optionally overriding `isApplicable()` to scope which pages it appears on.
   - For per‑entity data, add a class under `src/Plugin/JsonLdEntity/` annotated with
     `@JsonLdEntity`, implementing `isApplicable($entity, $view_mode)` to target a
     specific entity type / bundle / view mode, and `getData($entity, $view_mode)`.
3. Clear caches so the plugin is discovered. The module then emits your JSON‑LD
   automatically — sources on every applicable page, entity plugins whenever a
   matching entity is rendered.

The base classes provide helpers such as `absoluteUriString()` (turn an internal URI
into an absolute URL for `@id`/`url`) and `formatTimestamp()` (ISO‑8601 dates for
`datePublished`/`dateModified`). Ready‑to‑copy example plugins ship in the module's
test module. Other modules can also alter the available plugin definitions via
`hook_json_ld_source_info_alter()` and `hook_json_ld_entity_info_alter()`.
