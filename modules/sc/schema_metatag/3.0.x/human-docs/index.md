# Schema.org Metatag — manual setup guide

**Schema.org Metatag** (`schema_metatag`) is the base framework that lets
Drupal output **Schema.org structured data as JSON-LD** — the machine-readable
markup search engines read to show rich results (star ratings, prices, event
dates, FAQ accordions, breadcrumbs) next to your pages in search listings.
Instead of hand-writing `<script type="application/ld+json">` blocks, you
configure structured-data tags the same way you already configure meta tags.

The module builds directly on the **Metatag** module (`drupal/metatag` ^2.0,
which it requires). It adds new Schema.org meta tags and tag groups on top of
Metatag's normal definitions, then, as each page is rendered, it collects every
schema tag on the page, assembles the values into a nested structured-data
array, and emits a single JSON-LD `<script>` block in the page head. Because
the values are ordinary Metatag fields, they support **tokens** and can be set
globally, then overridden per content type or per individual entity — so your
structured data stays in sync with content edits automatically.

The base module has **no settings page and no tags of its own** — it is a
framework. You get actual Schema.org types by enabling the small companion
**submodules**, one per type: **Article** (`schema_article`), **Event**
(`schema_event`), **Product** (`schema_product`), **Recipe**
(`schema_recipe`), **Organization** (`schema_organization`), **Person**
(`schema_person`), **QAPage** (`schema_qa_page`), **WebSite**
(`schema_web_site`), **VideoObject** (`schema_video_object`) and many more.
Enable only the types you actually publish, then configure their tags under
Metatag.

This guide is written for a **human** clicking through the admin UI. If you
want terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the base module with
   Composer, then enable the per‑type submodules you need.

## Where it lives in the admin menu

Schema.org Metatag has **no configuration page of its own** (`configure` is
`null`). Everything is configured through the **Metatag** module once you have
enabled one or more of its type submodules:

1. Go to **Configuration → Search and metadata → Metatag**
   (`/admin/config/search/metatag`).
2. Edit a metatag defaults set (for example *Global*, *Content*, or a specific
   content type), or add a new one targeted at a bundle.
3. Each enabled schema type appears as its own **group** on the form (e.g.
   *Schema.org: Article*). Set the `@type` and fill in each property field,
   using tokens (such as `[node:title]` or `[node:field_image]`) so the values
   pull from your entity fields.
4. Save. On the next page render, Schema.org Metatag turns those tags into a
   JSON‑LD block in the page head.

Verify the result with Google's **Rich Results Test** or the Schema.org
validator by pasting in a rendered URL.
