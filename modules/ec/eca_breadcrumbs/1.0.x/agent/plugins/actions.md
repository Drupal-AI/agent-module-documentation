<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ECA actions

Three `@Action` plugins in `src/Plugin/Action/`. The two item-building actions extend
`BreadcrumbActionBase` (which extends ECA's `ConfigurableActionBase`) and operate on the
`BreadcrumbBuildEvent` obtained via `getBreadcrumbEvent()`; they no-op when the current event
is not that event. Config schema for the two `type = "breadcrumb"` actions is in
`config/schema/eca_breadcrumbs.schema.yml`.

## `eca_breadcrumbs_add_item` — "Breadcrumb: add item"

`AddBreadcrumbItem::execute()`. Config keys `title` (required, textfield) and `url`
(textfield, optional). Both are token-replaced with `tokenService->replaceClear()`. Empty
title → no-op. Calls `$event->addItem($title, $url ?: NULL)`; an empty URL becomes `NULL`
(current page). Before replacement it calls `prepareTokenData()` (see below).

## `eca_breadcrumbs_set_items` — "Breadcrumb: set items"

`SetBreadcrumbItems::execute()`. Single config key `items` (required, textarea). Format is
one `Title|URL` per line; empty URL = current page. `parseItems()` runs the text through
`tokenService->replacePlain()` then `strip_tags()`, splits on newlines, and on each line
splits on the first `|` (`explode('|', $line, 2)`), trimming both parts. Lines with an empty
title are dropped; a set of items then replaces the whole trail via `$event->setItems()`.

## `eca_breadcrumbs_set_applies` — "Does breadcrumb should apply"

`SetBreadcrumbApplies::execute()` (extends `ConfigurableActionBase` directly, not the base).
Config keys `applies` (checkbox, default TRUE) and `identifier` (required textfield,
token-supported). It acts only on a `BreadcrumbAppliesEvent` and calls
`$event->setApplies($applies, $identifier)` to register an active pipeline identifier. Pairs
with the `eca_breadcrumbs_identifier_active` condition (see
[events-conditions.md](events-conditions.md)). Note: the breadcrumb builder dispatches
`BreadcrumbBuildEvent`, not `BreadcrumbAppliesEvent`, so this action fires only if a
`BreadcrumbAppliesEvent` is dispatched — treat the identifier mechanism as advanced/partial.

## Token data

`BreadcrumbActionBase::prepareTokenData()` calls
`TokenDataHelper::addRouteParametersToTokenData()`, which loops the route match parameters and
registers each entity under its entity-type id (e.g. `node`, `user`, `taxonomy_term`) and each
scalar under its parameter name, so tokens like `[node:title]` resolve for the current page.
See [api/services.md](../api/services.md).

## URL resolution (at render)

Item URLs are resolved in the builder, not the action — `http(s)://` → `Url::fromUri()`,
leading `/` → `Url::fromUserInput()`, else `Url::fromRoute()`; a `Url` that fails to build is
skipped. Details in [api/services.md](../api/services.md).
