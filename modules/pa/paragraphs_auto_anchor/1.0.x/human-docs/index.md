# Paragraphs auto anchor — manual setup guide

**Paragraphs auto anchor** (`paragraphs_auto_anchor`) gives every rendered
Paragraph a stable, in‑page anchor so you can deep‑link straight to a specific
paragraph with a URL fragment — for example
`https://example.com/my-page#93f89463-cfc1-4d59-9a7b-be447a632d75`. The anchor id
is derived from each paragraph's **UUID**, so it stays the same across cache
clears and even when you reorder the paragraphs on a page.

There is nothing to configure and no settings form. Once the module is enabled it
works automatically: on the display side it injects a small anchor target at the
top of each paragraph's rendered output, and on the editing side it adds a
one‑click **Copy anchor to clipboard** button to the Paragraphs widget so editors
can grab a paragraph's shareable link right from the edit form. For paragraphs
added "from library" (reusable Paragraphs) it resolves the underlying reusable
paragraph's UUID, so the anchor points at the real item.

It depends only on the [Paragraphs](https://www.drupal.org/project/paragraphs)
module, defines no permissions, and adds no Drush commands.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module — it has no settings form. It
begins working the moment you enable it.

## Where it lives in the admin menu

Paragraphs auto anchor adds no admin page and no settings. It works wherever your
Paragraphs are rendered and edited.

## How to use it

1. Enable the module (see [Installation](installation/index.md)). Every paragraph
   on your site immediately gets a UUID‑based anchor target rendered before its
   content.
2. To share or link to a specific paragraph, edit the content, find the paragraph
   in the Paragraphs widget, and click **Copy anchor to clipboard**. That copies a
   fragment link (`#<uuid>`) you can append to the page URL.
3. Paste the full URL (page address plus the `#<uuid>` fragment) anywhere — a
   browser opening it scrolls straight to that paragraph. This is handy for
   "jump to section" navigation, table‑of‑contents links, FAQ deep links, or
   pointing marketing links at a specific block on a long page.

> **One caveat worth knowing:** the anchor is injected into the paragraph's
> `content` variable in the Twig template. If you override the default paragraph
> template, make sure your version still renders `content` the way the default one
> does, or the anchor target will not appear.
