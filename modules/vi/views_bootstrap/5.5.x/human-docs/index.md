# Views Bootstrap 5 — manual setup guide

**Views Bootstrap 5** (`views_bootstrap`) adds a set of Views **style plugins**
that render the results of a view as common Bootstrap 5 components — cards,
carousels, accordions, tabs, grids, list groups, dropdowns, media objects, and
styled tables. Instead of hand-writing Bootstrap markup, you build a view, choose
one of these styles under the display's **Format** section, and fill in a short
settings form for that component.

The module extends core Views with nine additional Format styles built around
Bootstrap 5's markup and utility classes. Each style ships its own Twig template
(`views-bootstrap-*.html.twig`) so the exact markup is overridable, and the module
registers per-view and per-display theme suggestions (for example
`views_bootstrap_cards__myview`) so you can target a single view. It depends only
on core **Views**, and there are no submodules.

Views Bootstrap 5 supplies the *markup*, not the styling — it **expects a
Bootstrap 5 theme** (or the Bootstrap framework's CSS/JS) to be present to provide
the actual look and interactive behaviors. A small JavaScript library is bundled
for carousel helpers, but Bootstrap's own CSS and JS must come from your active
theme. There is **no global admin settings page**: all configuration lives inside
each view's style options and is stored as view config, so it exports and deploys
with your normal config workflow.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (and make sure a Bootstrap 5 theme is in place).
2. [Configuration](configuration/index.md) — choose a Bootstrap style in the
   Views UI and set its options, style by style.

## Where it lives in the admin menu

There is no dedicated settings page. You use Views Bootstrap 5 entirely from the
**Views** UI (**Structure → Views**, `/admin/structure/views`): open a view,
click the **Format** setting for a display, and choose one of the *Bootstrap*
styles (Cards, Carousel, Accordion, Tab, Grid, List group, Dropdown, Media
object, or the Bootstrap table). See [Configuration](configuration/index.md) for
each style's options.
