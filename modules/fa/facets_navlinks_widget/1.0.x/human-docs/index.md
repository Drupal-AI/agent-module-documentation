# Facets Navigation Links Widget — manual setup guide

**Facets Navigation Links Widget** (`facets_navlinks_widget`) provides a
[Facets](https://www.drupal.org/project/facets) widget that renders facet values as
plain **navigation links** — a clean, SEO‑friendly way to present faceted
navigation in a menu or sidebar, rather than as checkboxes or a dropdown.

Facets already ships a "List of links" widget, but those links behave like toggle
buttons: clicking the active facet link resets it. That makes them awkward to use as
ordinary page links, and it introduces accessibility problems with screen readers.
This module's widget avoids both issues, giving you facet links that behave and read
like normal navigation.

It is purely a display widget — it has no content or access role of its own, and it
does not change what a visitor can see.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Facets dependency.

There is **no central configuration page** for this module — you choose the widget
on each facet, described in "How to use it" below.

## Where it lives in the admin menu

Facets Navigation Links Widget adds no admin page of its own. You select it from the
**Facets** admin UI (**Configuration → Search and metadata → Facets**,
`/admin/config/search/facets`) when editing an individual facet.

## How to use it

1. Create or edit the facet at **Configuration → Search and metadata → Facets**.
2. Under the facet's **Widget** setting, choose the **navigation links** widget
   provided by this module.
3. Save, then place/verify the facet block in the menu or sidebar region where you
   want it, and confirm the values render as navigation links.
