<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views Autocomplete API demo (views_autocomplete_api_demo) — agent index

Example/reference submodule of **views_autocomplete_api**. It demonstrates the parent module by
converting the **core search block** into a Views-driven autocomplete. Package `Views`. Core
`^10.3 || ^11.0`. Depends on `views_autocomplete_api` (and at runtime the core `search` block + `node`
article type). Not for production.

## What it ships (from source)
- **`views_autocomplete_api_demo.module`** — a single `hook_form_search_block_form_alter()`:
  sets `$form['keys']['#type'] = 'textfield'`, `#autocomplete_route_name = 'views_autocomplete_api'`,
  and `#autocomplete_route_parameters = ['view_name' => 'search_auto_publish,search_auto_unpublish',
  'display_id' => ',block_1']`. (Contextual-args line is commented out.)
- **`views_autocomplete_api_demo.install`** — `hook_install()` creates two `article` nodes:
  "Super test article publish" (`status: 1`) and "Bad test article unpublish" (`status: 0`).
- **`config/install/views.view.search_auto_publish.yml`** — example View on `node_field_data`, fields
  `nid` + `title`, exposed title filter; used as the first autocomplete source (default display).
- **`config/install/views.view.search_auto_unpublish.yml`** — second example View (uses its `block_1`
  display), demonstrating a separate source.
- No routes, services, permissions, schema, or plugins of its own.

## How the demo works
Typing in the core search field fires core's autocomplete JS against the `views_autocomplete_api` route
(see the parent's [routes/autocomplete.md](../../../2.1.x/agent/routes/autocomplete.md)); the two Views run
with the typed text injected into their exposed filters, and their rows come back as `{value,label}`
suggestions. The demo is meant to be read and copied into your own module, then disabled.

Parent module index → [`../../../2.1.x/agent/start.md`](../../../2.1.x/agent/start.md).
