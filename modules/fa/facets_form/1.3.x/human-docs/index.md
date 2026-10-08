# Facets Form — manual setup guide

**Facets Form** (`facets_form`) changes how faceted search filters are applied. With the core
[Facets](https://www.drupal.org/project/facets) module, each facet is a list of links and
clicking one applies that filter immediately. Facets Form instead renders a facets source's
facets as **real Form API elements** inside a single form with **Search** and **Clear**
buttons — so the user can tick several filters and apply them **all at once on submit**. This
is a much nicer experience on mobile and for multi-filter searches, and because the widgets
are genuine form elements they can be altered with `hook_form_alter()` and themed with
standard templates.

The module provides a **block** that is derived per facets source: place "Facet form:
<source>" and it builds a form containing every eligible facet for that source. A facet is
"eligible" when it uses one of Facets Form's own widgets — the two that ship are **Dropdown
(inside form)** and **Checkboxes (inside form)**. In the block you can limit which facets
appear and set the Search/Clear button labels. On submit the selected values become active
filters and the page redirects to the filtered URL; Clear strips the facet filters while
preserving other query parameters like paging and sort.

Four optional submodules extend it with a **date-range** widget, an **extended date-range**
widget with quick pickers ("this week", "last month"), a **fulltext** search box widget, and
a (deprecated) **live results count**. Facets Form requires the Facets module (2.x or 3.x)
and, in practice, Search API for the query side.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token-cheap references for an AI coding agent, read the sibling [`agent/`](../agent/start.md)
docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable it, and
   pick submodules.
2. [Configuration](configuration/index.md) — set the facet widgets, place the block, and tune
   the widget and button options.

## Where it lives in the admin menu

Facets Form has **no settings page of its own**. You work in two existing places: the
**Facets** admin (**Configuration → Search and metadata → Facets**) to set each facet's
widget, and **Structure → Block layout** (or Layout Builder) to place and configure the
"Facet form: <source>" block. There are no permissions specific to this module.
