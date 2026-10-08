# Facets View Mode Processor — manual setup guide

**Facets View Mode Processor** (`facets_view_mode_processor`) lets a
[Facets](https://www.drupal.org/project/facets) facet render its items through an
entity **view mode** instead of as plain text labels. Facets normally render as a
list of labels with counts, which is right for most filters — but limiting when the
facet's values are entities with something to show. A brand filter is more usable
with logos, a category filter reads better with an icon and short description, and an
author facet wants a photograph.

Producing that normally means overriding the facet template and loading each entity
by hand. This processor lets you pick a view mode instead, so the rendering is
configured in **Manage display** like everything else and the facet inherits whatever
the site already built. It is a single Facets **processor** plugin, enabled per facet
in the Facets UI, and it works with Facets `^2.0 || ^3.0`.

One consideration is worth knowing up front: **cost**. Rendering an entity per facet
item is far more work than printing a label — a facet with a hundred values renders a
hundred entities on every search. Keep it to facets with few values, verify your
render caching, and consider setting a hard limit on the facet. Also make sure the
HTML your view mode produces is valid inside a checkbox label; overriding the view
mode's template to keep the markup simple is recommended.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Facets.

There is **no module‑wide settings page** — the processor is enabled and configured
per facet, described in "How to use it" below.

## Where it lives in the admin menu

The module adds no admin page of its own. You configure it from **Configuration →
Search and metadata → Facets** (`/admin/config/search/facets`), on a facet built from
an entity‑reference field.

## How to use it

1. Create a facet based on an **entity‑reference field** (for example a taxonomy term
   reference).
2. Edit the facet and open its **processors**.
3. Enable **Transform entity ID to view mode**.
4. Choose the **view mode** the items should be rendered in (the view modes come from
   the referenced entity type's display configuration).
5. Save the facet. Each facet item is now rendered through that view mode, so it can
   show the entity's image, description, colour swatch, or any other field.

> **Tip:** override the chosen view mode's Twig template to control exactly how each
> facet item is rendered, and keep the markup valid for use inside a checkbox
> element. Favour this on short, visual facets rather than long lists.
