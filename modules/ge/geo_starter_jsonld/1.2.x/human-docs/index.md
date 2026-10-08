# GEO Starter JSON-LD — manual setup guide

**GEO Starter JSON-LD** (`geo_starter_jsonld`) adds **schema.org JSON‑LD
structured data** to pages built with the **GEO Starter** recipe. That structured
data is what lets search engines, answer engines, and AI retrieval systems read
the meaning of a page — its service, question and answer, article, or cited
source — rather than guessing from the raw HTML.

The module's guiding principle is honesty: it emits **one schema.org graph per
page**, only on the **full canonical view of a published node**, and only for
what the page actually renders. If a fact isn't visible on the page, it isn't
emitted. Different page types produce different structured data — Service pages
emit a `Service`, Answer pages emit a `Question` with its accepted answer,
Article pages emit an `Article`, Evidence Source pages emit a `CreativeWork`, and
sections can emit gated `FAQPage`, `HowTo`, or `ItemList` output when there's
enough real content to justify it. On any error, or any doubt, it emits nothing —
because invalid or inflated structured data is worse than none.

This is a **companion module for the GEO Starter recipe**, not a general‑purpose
JSON‑LD tool. It reads GEO Starter's specific content model and Paragraph types;
on a site without that content model it has nothing to emit. It ships as its own
Composer package only because a Drupal recipe can't carry a module on disk — the
recipe requires it, so it's installed automatically with GEO Starter, and you
normally don't install it by hand.

It depends on core's **Node** (`node`) module and the **Paragraphs**
(`paragraphs`) module. Because JSON‑LD exposes structured content to anyone who
reads the page source, only content that is meant to be public should end up in
it — which, by the module's design, is only what the page already shows.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — how it arrives with the GEO Starter
   recipe, and how to install it directly if you need to.

There is **no configuration page** for this module. It has no settings form: what
it emits is determined entirely by the GEO Starter content model and by what each
page renders.

## Where it lives in the admin menu

GEO Starter JSON-LD adds no admin page and no settings form. Once enabled
alongside the GEO Starter content model, it works automatically — emitting
structured data into the `<head>` of qualifying published pages. There is nothing
to click or configure.

## How to use it

There's no manual step once the GEO Starter recipe is in place. Publish a node
that uses the GEO Starter content model and view its full canonical page; the
module emits the appropriate schema.org JSON‑LD for that page type. To confirm
what's being produced, view the page source and look for the
`<script type="application/ld+json">` block, or paste the page URL into a
schema.org / structured‑data validator. Remember that teasers, search results,
editor previews, and unpublished nodes deliberately emit nothing.
