# Site Studio Views Element — manual setup guide

**Site Studio Views Element** (`site_studio_views_element`) adds a new element to
the Acquia Site Studio (Cohesion) builder palette that lets an author pick a View
and render it directly inside a component — no blocks, no hidden regions, no
developer required.

Site Studio is a visual page builder with its own vocabulary of elements, and
Views is where a Drupal site's dynamic listings live. Without a bridge between
them, putting a listing into a Site Studio page means a developer has to create a
block display of the View, place it in the theme's hidden region, and remember to
re‑place it in every environment. This module removes all of that: it gives you a
**Views element** you drop onto the canvas and configure by simply choosing the
View display you want. The element only offers **block displays** of Views (feeds,
pages and other display types are filtered out), so you pick exactly the listing
you mean.

The practical payoff is that listings stop being a developer task. A marketing or
editorial team can add "latest news, three items" or "events in this category" to
a landing page themselves, and the embedded listing keeps everything Views gives
it — filters, sorts, contextual arguments, pagers, access checks and caching —
because it is still the View doing the work.

It works on enable; there is **no settings form and no permissions of its own**.
It depends on the `cohesion` (Acquia Site Studio) module and core `views`. Site
Studio is Acquia's commercial product and needs a licence, so this module is only
useful on a site that already runs that stack. Because the element API belongs to
Site Studio (which versions on its own schedule), verify the element against the
Site Studio version you actually have installed.

This guide is written for a **human** setting the module up. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

Once the module is enabled, the workflow lives inside the Site Studio builder:

1. Build a new component (or edit an existing one).
2. Add the **Views Element** to the Layout Canvas.
3. Select the View display you wish to render.
4. Save the component.

Now, wherever you use that component, the View is injected automatically.
Contextual filters and other View settings are respected without any extra
configuration. This module pairs well with **Views Minimum Condition**.
