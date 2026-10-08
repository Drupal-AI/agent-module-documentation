# Facets Range NoUiSlider — manual setup guide

**Facets Range NoUiSlider** (`facets_range_nouislider`) gives the
[Facets](https://www.drupal.org/project/facets) module a modern **slider** control
for range facets. Instead of a list of range links, visitors filter results by
dragging a dual‑handle slider — a lower handle and an upper handle — and can
optionally type exact values into companion min/max input boxes. It is the natural
control for price, rating, year, or any numeric field.

The slider is built on the lightweight **noUiSlider** JavaScript library rather than
jQuery UI, so it stays small and is configurable directly from the facet's widget
settings. The module ships two widget variants — a plain noUiSlider widget and a
range noUiSlider widget — and attaches the JS library automatically wherever the
widget renders. It builds on both the Facets module and its **Facets Range Widget**
submodule, which must be enabled.

Because the noUiSlider JavaScript library is not bundled, you install it separately
with Composer (via Asset Packagist) — see the installation guide.

There is no separate settings page. You choose the slider widget and tune its
options (min, max, step, input boxes) on the individual facet's edit form.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, add the
   noUiSlider library, and enable the module and its dependencies.

There is **no module‑wide configuration page** — the widget and its options are set
on each facet, described in "How to use it" below.

## Where it lives in the admin menu

The module adds no admin page of its own. You use it from **Configuration → Search
and metadata → Facets** (`/admin/config/search/facets`), on the edit form of the
numeric range facet you want to present as a slider.

## How to use it

1. Make sure Facets and its **Facets Range Widget** submodule are enabled, and that
   you have a **numeric range facet** on a Search API facet source.
2. Edit the facet at **Configuration → Search and metadata → Facets**.
3. For the facet's **widget**, choose the noUiSlider widget (or the range noUiSlider
   variant).
4. Configure the widget options — the slider's **min**, **max** and **step**
   increments, and whether to show numeric input boxes before or after the slider.
5. Save the facet. On the search page the facet now renders as a draggable slider;
   the noUiSlider library is loaded automatically. The input fields respond to key
   up, key down and Enter for precise entry.

Use it wherever a numeric facet is easier to use as a slider than as a checkbox
list — especially for large ranges such as price or year.
