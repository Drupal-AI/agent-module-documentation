# Metatag Page Heading — manual setup guide

**Metatag Page Heading** (`metatag_page_heading`) lets you override a page's visible
heading — the `<h1>` that Drupal calls the "page_title" — while leaving the entity's
label untouched. It is useful whenever the on-screen title should read differently
from the entity's actual label. For example, a "Job" node whose label is *Drupal
Developer* could display the heading *Great Drupal Developer Job* for better SEO and
a friendlier read, using a token pattern like `Great [node:title] Job`.

It works by adding a new **"page_heading"** meta tag through the
[Metatag](https://www.drupal.org/project/metatag) module's infrastructure. Despite
being a "metatag", the value is never rendered as an actual `<meta>` tag — instead
the module uses Metatag's token and attachment machinery to override the visible
heading anywhere meta tags can be set: content, taxonomy terms, and more. It depends
on the Metatag module.

One important caveat: the override is applied via `hook_preprocess_page_title`, which
replaces the whole title render. That means any Twig title theming your theme
provides (extra `<h1>` child elements or classes) will be lost. If that matters for
your theme, the module's page suggests
[`node_title_ps`](https://www.drupal.org/project/node_title_ps) as a lighter
alternative.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Metatag dependency.

There is **no dedicated configuration page** — you set the page heading wherever you
already set meta tags (see "How to use it").

## Where it lives in the admin menu

The module adds no admin page of its own. After installation, a new **Page Heading**
metatag group appears within the Metatag configuration, providing the
**Page heading (h1)** tag.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Open any Metatag form — the global/bundle defaults under **Configuration →
   Search and metadata → Metatag**, or a per-entity Metatag field on a node or
   taxonomy term.
3. In the **Page Heading** group, set the **Page heading (h1)** value. You can type
   plain text or use tokens such as `Great [node:title] Job`.
4. Save. The visible `<h1>` on matching pages is overridden with your value while
   the entity's stored label stays the same.
