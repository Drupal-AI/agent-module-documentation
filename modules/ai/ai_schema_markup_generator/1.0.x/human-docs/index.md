# AI Schema Markup Generator — manual setup guide

**AI Schema Markup Generator** (`ai_schema_markup_generator`) uses AI to
**automatically generate Schema.org structured‑data markup for your content**. It
analyses a page and produces appropriate JSON‑LD — Article, Product, FAQ, and so
on — so your pages become eligible for search‑engine rich results without you
hand‑writing the schema.

Structured data helps search engines understand what a page is about. Writing it
by hand is fiddly and easy to get wrong; this module drafts it for you from the
content already on the page. It builds on Drupal's AI ecosystem and provides its
own permission for controlling who can use it.

Two things matter before you rely on it. The **page content is sent to the
configured AI provider** to generate the schema (external egress — confirm that
is acceptable; the provider key is stored as a secret via the AI module and Key).
And you should **review the generated schema before publishing it** — incorrect
structured data can hurt your SEO or misrepresent the page. The module has no
access‑control role beyond the permission it provides.

This guide is written for a **human**. If you want a terse, token‑cheap
reference for an AI coding agent, read the sibling [`agent/`](../agent/start.md)
docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

1. **Install and enable** the module (see [Installation](installation/index.md)).
2. **Configure an AI provider** in the AI module with its API key stored as a
   Key — this is what generates the markup.
3. **Grant the module's permission** at **People → Permissions** to the roles
   that should be able to generate schema.
4. **Generate schema** for your content, then **review the JSON‑LD** before it
   goes live. Remember the page content is sent to your AI provider, so confirm
   that egress is acceptable.
