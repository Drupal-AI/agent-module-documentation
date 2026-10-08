<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DOI Publications (doi_search) — agent index

Resolves a **DOI** to its scholarly-publication metadata via the **Crossref API** and displays it on a
search page, plus a reusable service other modules call. Package `Custom`. Core
`^8.8 || ^9 || ^10 || ^11`. License GPL-2.0-or-later. Version 2.0.1 (version dir `2.0.x`).
No composer deps, no module deps, no config objects, no settings form.

- **The search page/route/form, the `doi_search.manager` service + Crossref call, and the result
  templates** → [api/search.md](api/search.md)

## What it actually is (from source)

- **One route** `doi_search.page` → `/doi-search`, `_controller`
  `DoiSearchController::build`, `_permission: access doi search` (`doi_search.routing.yml`).
- **One permission** `access doi search` (`doi_search.permissions.yml`). No `restrict access`; not
  granted to anonymous by default.
- **One service** `doi_search.manager` = `Drupal\doi_search\DoiSearchManager`, args
  `@messenger`, `@http_client` (`doi_search.services.yml`). Method `getData($doi)` queries Crossref
  and returns the `message` object.
- **One form** `SearchForm` (id `doi_search_search`, `src/Form/SearchForm.php`) — a required `DOI`
  textfield that redirects to `doi_search.page?doi=<value>` on submit.
- **Three themes** (`doi_search_theme()` in `doi_search.module`): `doi_search_page`,
  `doi_search_result`, `doi_search_reference`, backed by the templates in `templates/`.
- **`hook_help()`** renders `README.md` on `help.page.doi_search` (via the `markdown` module if
  present, else `<pre>`).
- No install/schema/config-install files, no Drush, no plugins, no entities, no submodules.

## Dependencies

None declared (no `composer.json`; `doi_search.info.yml` lists no `dependencies`). Uses only core
services (`messenger`, `http_client`, `form_builder`, `request_stack`). Needs outbound network
access to reach Crossref. The `doi_field` project depends on this module.
