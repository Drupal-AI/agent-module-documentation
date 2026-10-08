# Facets autocomplete — manual setup guide

**Facets autocomplete** (`facets_autocomplete`) adds an autocomplete widget to the
[Facets](https://www.drupal.org/project/facets) module. A facet with hundreds of
possible values — a "manufacturer", "author", or "location" facet, say — becomes
an unusable wall of checkboxes that is longer than the results it filters. This
module renders that facet as a type‑ahead text field instead: the visitor starts
typing and matching values appear, so they can jump straight to the one they want.

It is a **widget**, not a new kind of facet. You select it per facet in the Facets
UI, and it changes nothing about how the facet is defined, sourced, or indexed —
you can switch a facet to autocomplete and back with a single setting, with no
re‑indexing. Under the hood it ships the widget plugin along with its JavaScript,
CSS, and a Twig template, and it works with both Facets 2.x and 3.x, which is handy
if your site is mid‑upgrade.

One thing worth thinking about before you switch: autocomplete changes how values
are *discovered*. A visitor can only find a value they can at least partially
spell, so a facet meant for open‑ended browsing may actually be worse as an
autocomplete than as a truncated checkbox list. It is at its best on large,
well‑known value sets. When you configure it, also check how it behaves with an
empty result set and how it interacts with the facet's "hard limit / show all"
settings.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Facets dependency.

There is **no central configuration page** for this module — you choose the
autocomplete widget on each facet, described in "How to use it" below.

## Where it lives in the admin menu

Facets autocomplete adds no admin page of its own. You select it from the **Facets**
admin UI (**Configuration → Search and metadata → Facets**,
`/admin/config/search/facets`) when editing an individual facet.

## How to use it

1. Create your facet as usual on the **Facets** admin page and point it at its
   Search API‑backed source.
2. Edit the facet and, under the **Widget** setting, choose the **autocomplete**
   widget.
3. Save. The facet now renders as a type‑ahead field. To revert, edit the facet
   again and pick a different widget — no re‑indexing is needed either way.
4. Test the facet with real data, including an empty result set, and confirm it
   works well alongside any hard‑limit / show‑all settings on that facet.
