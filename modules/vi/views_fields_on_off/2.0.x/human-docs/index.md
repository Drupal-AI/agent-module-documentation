# Views Fields On/Off — manual setup guide

**Views Fields On/Off** (`views_fields_on_off`) lets your site visitors choose which
fields (columns) of a View they want to see, right from the View's exposed form.
Think of a wide table report where different people care about different columns:
with this module you add a set of checkboxes (or radios, or a select) to the exposed
form, and each visitor turns the columns they don't want off — tailoring the display
without any custom code.

It works by adding two exposed Views handlers, both with the plugin id
`views_fields_on_off_form`: a **field** handler ("Global: On/Off Form") and a
**filter** handler ("Global: On/Off Filter"). In the handler's options you pick
which of the View's other fields the visitor may toggle, choose the widget
(checkboxes, radios, a single select, or a multi‑select), and decide whether those
fields start shown or hidden. At view‑time the module reads the visitor's choice and
simply excludes the unselected fields from the rendered output.

Importantly, it is safe by design: it never adds fields to the query. It only hides
fields you already configured in the View, so it can shrink a display but can never
surface data you hadn't already exposed. The selection is read from the request —
POST for AJAX Views, GET otherwise — so it also works with AJAX and lets visitors
deep‑link a column selection by sharing the query string.

The field variant is the simpler "always exposed" toggle; the filter variant extends
Views' `InOperator`, so it gains exposed‑filter grouping and identifier features,
plus a `not in` operator to invert the selection and a **Bypass hook_views_pre_view()**
option for modules (like Charts) that read fields earlier in the render. There is no
global settings page and no permission — it is configured entirely inside a View —
and it works on Drupal 8.8 through 11 using only core Views.

This guide is written for a **human** working in the Views UI. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Nowhere on its own — there is no settings page. You use it from inside a View at
**Structure → Views**, by adding the On/Off field or filter handler.

## How to use it

1. Edit a View that has fields (for example a table listing).
2. Add either **Global: On/Off Form** (a *field*) or **Global: On/Off Filter** (a
   *filter*) to the display.
3. In the handler's options:
   - **Fields** — choose which of the View's fields the visitor may toggle. (For the
     field handler, only fields positioned *before* it in the field list are
     offered, so place it after the fields you want to control.)
   - **Exposed widget** — pick checkboxes, radios, a single select, or a
     multi‑select.
   - **Default** — for the field handler, choose whether the fields start shown
     (`default_enabled`) or hidden. For the filter handler, remember to tick
     **Expose this filter** so it appears.
4. Save the View. Visitors now get the toggle in the exposed form and can show or
   hide the configured columns.

Handy extras: use the filter's **not in** operator so the selected fields are the
ones *hidden*; pair it with **Views Data Export** so users export only the columns
they chose; and enable **Bypass hook_views_pre_view()** on the filter if an
earlier‑reading module such as **Charts** needs the toggled fields resolved before
render.
