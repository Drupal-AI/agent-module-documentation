# Facets Content type or Other — manual setup guide

**Facets Content type or Other** (`facets_content_type_or_other`) provides a way to
facet a listing by content type, but with a twist: instead of showing every
content type as its own option, you can fold the ones you do not care about into a
single **"Other"** bucket. So a faceted search can offer, say, *Article*, *Basic
page*, and *Other* — where *Other* collects everything else — keeping the facet
tidy on sites with many content types.

It works by indexing a special "Content type or other" value alongside your
content, which you then expose as a Facets facet. A small settings form lets you
decide how each content type is labelled and which ones are grouped into "Other",
and a dedicated sort option keeps the facet in a sensible, predictable order.

The module is a display/faceting helper: it shapes how content types appear in a
facet and never changes what a visitor is allowed to see — the listed results
still respect their own access rules.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Facets dependency.
2. [Configuration](configuration/index.md) — the settings form, the Search API
   field, and the facet, step by step.

## Where it lives in the admin menu

The module's own settings form is at **Configuration → Search and metadata →
Content type or Other** (`/admin/config/search/facets-content-type-or-other`). The
matching field is added on your Search API index, and the facet is created on the
**Facets** admin pages.
