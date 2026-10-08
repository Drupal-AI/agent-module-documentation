<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ECA Breadcrumbs (eca_breadcrumbs) — agent index

An ECA integration that lets a breadcrumb trail be built from an ECA model instead of PHP.
It registers one core `breadcrumb_builder` service (`eca_breadcrumbs.breadcrumb_builder`,
**priority 1005** in `eca_breadcrumbs.services.yml`) that dispatches an ECA event on every
route; ECA actions then populate the trail with token support. Package `Custom`. License
GPL-2.0-or-later. Core `^10 || ^11`, PHP `>=8.1`. Version 1.0.0.

- **Depends on** core `system`, `eca:eca`, `token:token` (see `eca_breadcrumbs.info.yml` /
  `composer.json`).
- **No** routes, permissions, Drush commands, or settings form. No config entities; only
  action config schema in `config/schema/eca_breadcrumbs.schema.yml`.

## What it provides

- **ECA event** `eca_breadcrumbs:build` ("Build breadcrumb") — derived plugin; the pivot of
  every model. → [plugins/events-conditions.md](plugins/events-conditions.md)
- **ECA condition** `eca_breadcrumbs_identifier_active` ("Breadcrumb pipeline identifier is
  active"). → [plugins/events-conditions.md](plugins/events-conditions.md)
- **ECA actions** `eca_breadcrumbs_add_item`, `eca_breadcrumbs_set_items`,
  `eca_breadcrumbs_set_applies`. → [plugins/actions.md](plugins/actions.md)
- **Services & hooks** — the breadcrumb builder, the `TokenDataHelper`, the two events, and
  the `[breadcrumb:route-name]` token. → [api/services.md](api/services.md)

## Quick mental model

The builder `applies()` dispatches `BreadcrumbBuildEvent`; your ECA model's actions add/set
items on that event. If items were set, `build()` renders them as links (empty URL →
non-linked current page via `<nolink>`); if not, the builder returns `NULL` and Drupal's
default breadcrumb builders run. Install/enable and operation details are in the solution
docs above.
