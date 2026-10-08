# Taxonomy Bootstrap Accordion — manual setup guide

**Taxonomy Bootstrap Accordion** (`taxonomy_bootstrap_accordion`) gives you a
single block that renders one or more taxonomy vocabularies as a **Bootstrap
accordion**. Each vocabulary becomes a collapsible panel, and the terms inside it
are listed as links to their term pages. It is a quick, no-code way to publish a
taxonomy-driven navigation or category browser — a sidebar of product categories,
a glossary grouped by vocabulary, or an expandable documentation index.

You configure everything on the block itself: which vocabularies to include, and
which **Bootstrap version** (3, 4, or 5) your theme uses so the block emits the
matching markup and data attributes. When a visitor is on a page that matches one
of the terms, that term is highlighted and its panel is expanded automatically.
The block also sets the right cache tags, so it refreshes on its own whenever terms
are added, edited, or deleted.

One thing to keep in mind: the module provides the accordion *markup* but not the
Bootstrap CSS and JavaScript that make it collapse and expand. Those must come from
your theme (for example a Bootstrap-based base theme). If your theme does not load
Bootstrap, the panels will render but will not behave as an interactive accordion.
The module depends only on core's **Taxonomy** module, and has no permissions, no
Drush commands, and no central settings page — configuration lives entirely on
each block instance. The output is themed through an `accordion-group` template
you can override.

This guide is written for a **human** working through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

There is no settings page. You place and configure the block at **Structure →
Block layout** (`/admin/structure/block`) using **Place block** and choosing
**Taxonomy Bootstrap Accordion** (it appears in the *Menus* category).

## How to use it

1. Make sure your theme loads Bootstrap CSS/JS (otherwise the accordion will not
   collapse).
2. Go to **Structure → Block layout**, pick a region, and click **Place block**.
3. Choose **Taxonomy Bootstrap Accordion** from the list.
4. In the block configuration form, set:
   - **Vocabularies to Include** — check the vocabularies you want to appear as
     panels. They are listed in vocabulary-weight order, and only the ones you
     check are shown. You can include several vocabularies in one block.
   - **Bootstrap Version** — pick **3**, **4**, or **5** to match your theme. This
     controls the classes and data attributes the block emits (for example
     `panel-group` for Bootstrap 3, `card`-based markup for 4 and 5, and
     `data-toggle` versus `data-bs-toggle` attributes).
5. Save the block. Each selected vocabulary renders as a collapsible panel of term
   links; the term matching the current page is highlighted and expanded.

To place different vocabulary selections in different regions, simply add the block
more than once with different settings. To change the markup, override the
`accordion-group.html.twig` template in your theme.
