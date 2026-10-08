# JSON-LD Generator — manual setup guide

**JSON-LD Generator** (`jsonld_generator`) is a configuration-driven way to add
Schema.org **structured data** to your Drupal node pages, so search engines
understand your content better and it becomes eligible for rich search results —
without writing any custom PHP. You enable structured data per content type,
choose the right Schema.org `@type`, and the module builds the JSON-LD from your
existing node fields and injects it into the page `<head>`.

Out of the box it maps the standard node fields to Schema.org properties: the
title becomes `headline`, the created date becomes `datePublished`, the updated
date becomes `dateModified`, and the body becomes `description`. For anything the
automatic mapping doesn't cover, each enabled content type also gets a **Custom
JSON-LD** field on the node edit form, where an editor can override or extend the
generated markup — the custom JSON is merged with the generated schema and
validated before the node is saved, so invalid structured data never gets
published.

It supports the common Schema.org types you are most likely to need — Article,
BlogPosting, NewsArticle, Product, Event, FAQPage, Organization, Person,
LocalBusiness, and WebPage — which covers editorial sites, blogs, product pages,
event listings, and business sites. It needs no external libraries or third-party
APIs, only core's Node and Field modules.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.
2. [Configuration](configuration/index.md) — enable structured data per content
   type, pick each type's Schema.org `@type`, and use the per-node override field.

## Where it lives in the admin menu

After enabling the module, its settings live at **Administration → Configuration
→ Search and metadata → JSON-LD Generator**. That is where you turn structured
data on for each content type and choose its Schema.org `@type`.

## How to use it

Once you have enabled a content type and picked its `@type`, the module does the
rest automatically: it creates and attaches the shared JSON-LD field, configures
the form and view displays, and injects the generated JSON-LD into the `<head>`
whenever an enabled node is viewed. Editors only need to touch the optional
**Custom JSON-LD** field when they want to override or add to what is generated.

Modules like **Metatag** (for other meta tags) and **Schema.org Blueprints** (for
advanced Schema.org modelling) complement JSON-LD Generator but are not required.
