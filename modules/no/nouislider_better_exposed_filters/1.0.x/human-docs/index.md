# NoUiSlider — manual setup guide

**NoUiSlider** (`nouislider_better_exposed_filters`) integrates the
[noUiSlider](https://github.com/leongersen/noUiSlider) JavaScript library into
[Better Exposed Filters](https://www.drupal.org/project/better_exposed_filters)
(BEF), so a multi‑value **select** exposed filter in a View renders as a
draggable **slider** instead of a select list. It is aimed at ordered option
sets — a taxonomy of rating buckets, an ordered attribute such as size, and the
like — where dragging across a labelled range is a friendlier, more
touch‑friendly control than a long multi‑select box.

Under the hood it adds a single BEF widget (id `bef_nouislider`). When you apply
it, it acts only on `select` elements that are multi‑value: it hides the real
select and injects a slider next to it, then keeps the two in sync so the normal
Views exposed‑form submit (including AJAX refresh) still works. The one option it
offers is **Pips mode** — `range` for a continuous labelled scale or `steps` for
discrete labelled stops. Because it simply decorates an existing exposed filter,
its access behaviour is entirely that of the View it sits on — it has no routes,
permissions, services, or admin config of its own.

Two things it needs to work: the **Better Exposed Filters** module, and the
**noUiSlider** JavaScript library (version 15.7.x or newer) placed in your
site's libraries directory. The Installation page covers both.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and the noUiSlider
   library, and enable it alongside Better Exposed Filters.

There is **no configuration page** for this module — it has no settings form. All
configuration happens inside a View's Better Exposed Filters settings, described
in "How to use it" below.

## Where it lives in the admin menu

NoUiSlider adds no admin page. You use it entirely from the **Views UI**: edit a
View, open the exposed filter's **Better Exposed Filters** settings, and choose
the NoUiSlider widget for the relevant filter.

## How to use it

1. Make sure the filter you want to convert is an **exposed** filter that
   produces a **multi‑value select** (for example a taxonomy or entity‑reference
   filter set to allow multiple values).
2. Edit the View and, in the exposed filters area, open the **Better Exposed
   Filters** settings.
3. For that filter, choose the **NoUiSlider** widget (this option only appears
   once this module is enabled).
4. Pick a **Pips mode**: **range** for a continuous labelled scale, or **steps**
   for discrete labelled stops with tick marks.
5. Save the View. Visitors now filter by dragging the slider's handle(s) across
   the ordered options; the underlying select stays in sync so results update
   normally, including with AJAX.
