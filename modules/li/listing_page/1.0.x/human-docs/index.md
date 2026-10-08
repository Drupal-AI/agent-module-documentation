# Listing page — manual setup guide

**Listing page** (`listing_page`) lets you render a Views listing *inside a content
entity* rather than on a standalone Views page. Core Views already has a "Page"
display that gives a view its own route — and that works well for sites that don't
change much. But the moment your client wants to change the URL alias, translate
the route, adjust the page title, edit the metatags, or drop some extra content
(paragraphs, a hero, an intro) onto the listing, you're back in the Views UI,
exporting and importing configuration to deploy each tweak.

This module moves all of that into content scope. You build a view once, add a
special **Listing page** display to it, and then create nodes (of a content type
you design, e.g. *Listing*) that each point at a view. Because the page is now a
node, editors get the normal content tools — URL alias, metatags, translation,
title, paragraphs — without touching the Views UI or config deployment. It
supports Search API‑based views, Facets, and Tokens.

It depends on core's **Field** and **Views** modules plus the contributed
**Token** module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no global settings page**. All configuration happens on your view, your
content type, and the individual Listing page nodes — described in "How to use it"
below.

## Where it lives in the admin menu

Listing page adds no dedicated admin settings page. You work with it through
**Structure → Views** (to add the Listing page display), **Structure → Content
types** (to build the container content type and add its field), and then through
the normal **Content** add/edit screens.

## How to use it

The setup has two halves — configure once, then let editors create listing pages.

**Configure your view and content type:**

1. Create a view that lists your content — for example a *News* view listing the
   News content type.
2. Add a **Listing page** display to that view.
3. Create and configure a content type — say *Listing* — the way you normally
   would.
4. Add a field of type **Entity listing information** to that content type (for
   example `field_listing`). This field holds which view lists things and which
   content type the listed things are.
5. Theme your view and your nodes as usual.

**Add content:**

1. Create a piece of *Listing* content and choose your view (for example *News*).
2. Give the node a URL alias, adjust its metatags, add paragraphs or other
   content, and set its title — all from the normal node edit form.

The result is a listing page your editors fully own, with the filtering and
sorting power of Views behind it. See the module's README for more on Search API,
Facets, and Token support.
