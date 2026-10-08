# Active Filters — manual setup guide

**Active Filters** (`active_filters`) gives a View with exposed filters a row of
"active filter" chips that show visitors exactly which filters are currently
applied — and lets them clear each one individually, or all at once. It's the
faceted-search "you searched for: Category: News ✕" experience, built directly on
core Views, with no facets module required.

It works as a Views **area** handler (the same kind of thing as a header or footer
text area). You add **Global: Active Filters** to a display's Header or Footer, and
it reads the current exposed-filter selections, turns each into a chip, and renders
them with a small amount of shipped CSS. Clicking a chip's ✕ unsets the matching
exposed input and resubmits the view via JavaScript; a "Clear all" button resets
everything at once. It handles checkboxes, radios, single and multiple selects, and
text inputs out of the box, and offers a hook for JS-enhanced widgets that need
custom reset logic.

There's no global settings page — every option lives on the area handler itself,
so you configure it right there in the Views UI: heading text, whether to group
chips under each exposed filter, the clear-all button label, and per-filter options
including value **rewriting** (show "Yes" instead of "1", or hide one side of a
boolean). The output is fully themeable through four theme hooks with granular
per-view/display/filter/value suggestions, and every value is emitted through
Twig's autoescaping, so it's safe by default. It depends on core **Views** and
requires **PHP 8.2+**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent — including the theming hooks
and the `hook_active_filters_alter()` API — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Views.
2. [Configuration](configuration/index.md) — adding the area to a View and all its
   per-area and per-filter options, including value rewriting.

## Where it lives in the admin menu

There is no settings page of its own. You add and configure it inside the **Views**
UI (*Structure → Views*, edit a display): **Add** to *Header* or *Footer*, then
choose **Global: Active Filters**. It's only useful on a display that has exposed
filters.
