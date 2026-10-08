# Charts Exposed Settings — manual setup guide

**Charts Exposed Settings** (`charts_exposed_settings`) lets site visitors set
some of a chart's labels themselves. It adds Views field and filter plugins that
you place on a Views‑based chart, and — because they can be **exposed** — they
turn into form inputs on the page that populate the chart's:

- **Title**
- **Subtitle**
- **X‑axis label**
- **Y‑axis label**

The problem it solves is interactivity: instead of a fixed chart, you can offer a
report where a viewer types their own title or axis labels and the chart updates
to match. It's an add‑on to the **Charts** module and only makes sense on a chart
built with Views.

Under the hood the module reads the corresponding query parameters
(`chart_title`, `chart_subtitle`, `x_axis_title`, `y_axis_title`) and writes them
into the Charts style settings before the View renders. The values a visitor
supplies are run through Drupal's XSS filter before being applied, and the output
carries a URL cache context — so exposing these inputs to the public is safe by
design. The module has **no settings form, no permissions, and no stored
configuration** of its own; everything is set up on the View.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module. You add the exposed fields or
filters to your chart View, described in "How to use it" below.

## Where it lives in the admin menu

Charts Exposed Settings adds no admin page. You use it entirely from the **Views
UI** (**Structure → Views**), on a View that already produces a chart with the
Charts module.

## How to use it

1. Enable the module (see [Installation](installation/index.md)); the Charts and
   Views modules must already be installed and configured.
2. Create a chart in Views (a View using the Charts style/format).
3. Add one or more of this module's handlers to the View — each is available as
   both a **field** and a **filter**:
   - Exposed **title**
   - Exposed **subtitle**
   - Exposed **X‑axis title**
   - Exposed **Y‑axis title**
4. **Expose** the ones you want visitors to control. When the View renders, those
   exposed inputs appear on the page and their values populate the matching chart
   settings.
