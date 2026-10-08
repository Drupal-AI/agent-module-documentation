# Better Exposed Filters — manual setup guide

**Better Exposed Filters** (`better_exposed_filters`, often shortened to **BEF**)
upgrades the exposed filters on a View. When you expose a filter, sort, or pager
in Views so visitors can refine a listing, Drupal renders those controls as plain
HTML `<select>` boxes. BEF replaces them with richer widgets — checkboxes, radio
buttons, clickable links, range sliders, date and datetime pickers, and more — so
your filtered listings and faceted‑search pages look and behave the way you want.

Beyond swapping the widget, BEF adds behavioral polish: auto‑submit (the view
refreshes as soon as a visitor changes a filter), hiding the submit button for a
live‑search feel, "select all / none" links for checkbox filters, soft limits
with "show more / show less" toggles, collapsible fieldsets, a secondary
"advanced options" group, a reset link, and the ability to rewrite filter option
labels. It works the same way for exposed **sorts** and **pagers**, which can
become links or radio buttons too.

BEF works **per View** — there is no global settings page. You turn it on inside a
single view's **Exposed form** settings and then configure each widget there, so
all the configuration is stored with the view and deploys along with it. It
depends on core's **Views** module, and it pulls in the noUiSlider JavaScript
library (via `drupal/nouislider_js`) which is only used if you choose a slider
widget.

This guide is written for a **human** clicking through the Views UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — turn BEF on for a view and walk
   through the widget and behavior options.

## Where it lives in the admin menu

BEF has no page of its own under **Configuration**. It surfaces inside the Views
UI: edit a view at **Structure → Views → (your view)**
(`/admin/structure/views/view/<id>`), and in the display's **Exposed form**
section you set the exposed form style to **Better Exposed Filters**. See
[Configuration](configuration/index.md) for the full walkthrough.
