<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views integration: HTMX display + HTMX mini pager

Implementations of core Views plugin types (the module defines no new plugin type).

## HTMX display plugin (id `htmx`)

`Drupal\htmx\Plugin\views\display\Htmx` extends `PathPluginBase` (like a Page display) with
attribute `#[ViewsDisplay(id: "htmx")]`, admin label **HTMX**. It renders the view as a
**simple page** at a URL meant for HTMX requests (bare render, swap-ready). Add it like any
display: in the Views UI, *Add* → **HTMX**, then set its **Path**. Config schema
`views.display.htmx` (adds `use_admin_theme`).

When a view uses the `htmx` display, `htmx_form_views_exposed_form_alter()` rewires the
**exposed filter form** to submit via HTMX: the submit button gets `hx-get` to the form action
with `hx-include="form.views-exposed-form"`, `hx-select`/`hx-target="div.views-element-container"`,
`hx-swap="outerHTML"`, and the display's `push_url` — so filtering swaps only the results.

## HTMX mini pager (id `htmx_mini`)

`Drupal\htmx\Plugin\views\pager\HtmxMini` — a mini pager whose Previous/Next links carry
`hx-get` attributes that swap the view's container in place (targeting
`div[data-htmx-display="<view>--<display>"]`, added by `htmx_preprocess_views_view()`), using
the pager's `htmx_options.pager_push_url`. Select it under the view's **Pager → Mini (HTMX)**.
It renders through the themable `htmx_mini_pager` template and attaches the `htmx/views`
library (CSS). Config schema `views.pager.htmx_mini`.

Together they give a Views listing in-place AJAX paging + exposed-filter swaps without core's
big AJAX machinery — just HTMX partial `hx-get` swaps.
