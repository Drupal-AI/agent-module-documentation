# Entity Markup — manual setup guide

**Entity Markup** (`entity_markup`) gives site builders a UI to control the
**output markup** — the HTML wrappers and tags — around rendered entities and
their fields, so you can make small markup tweaks from the admin interface instead
of writing Twig template overrides. If all you need is something simple, like
rendering a title field with a particular heading tag or stripping an unwanted
wrapper element, this module lets you do it as configuration rather than adding
yet another template file to your theme.

Its distinguishing feature is that it works **per field, per view mode** — so the
same field can carry different markup on a teaser than it does on the full display.
That's a step up in granularity from the similar Fences module (which works per
field only), and it stays out of the way of layout: unlike Display Suite it isn't a
full layout manager, so you can keep using Drupal core's Layout Builder while still
adjusting field markup here. For genuinely complex cases, Twig overrides are still
available; Entity Markup is aimed at the many simple cases that don't warrant one.

Entity Markup depends on Drupal core's **Field** module and runs on Drupal 8.9
through 11. It changes only the rendered HTML structure — it does not touch field
data or access.

**A note on trust:** because this module lets an administrator control the markup
that wraps rendered output, treat the ability to configure it as an
**admin-trusted** capability. Markup control in the wrong hands can be used to
introduce unwanted or unsafe HTML into pages, so grant access to the display
settings only to roles you already trust with site building, and review changes
the way you would review a template edit. Note also that the module is **not**
covered by Drupal's security advisory policy.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no central settings form** for this module — you set markup per field on
each bundle's **Manage display**, described in "How to use it" below.

## Where it lives in the admin menu

Entity Markup adds no menu item of its own. You use it from a bundle's display
settings under **Structure → Content types (or any entity type) → *(bundle)* →
Manage display**, per view mode.

## How to use it

1. Go to a bundle's **Manage display** and select the view mode you want to adjust
   (Default, Teaser, and so on).
2. For a field, open its markup settings and choose the wrapper/tag you want — for
   example render a title field inside an `<h2>`, or remove a wrapper element
   entirely.
3. Save the display. The rendered HTML for that field, in that view mode, now uses
   your configured markup — no Twig override required.
