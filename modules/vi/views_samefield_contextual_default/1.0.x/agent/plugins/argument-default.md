<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views Same field Contextual Default — plugin (views_samefield_contextual_default)

Provides the Views **argument default** plugin `samefield_contextual_default`
(title *"Same field value from route context"*), class `DefaultValue` extending
`ArgumentDefaultPluginBase`.

## What it does
On a contextual filter for an entity field, when no argument is present in the URL, the
plugin reads the **same field** from the entity in the current route and uses its value(s)
as the argument. `getArgument()`:
1. takes the contextual filter's configured `entity_type` + `field_name`;
2. loads that entity from the route via `RouteMatchInterface::getParameter($entity_type)`;
3. if it has the field and it is non-empty, collects the values with
   `array_column(...->getValue(), key(first value))` — auto-detecting the storage property
   (`value`, `target_id`, …).

## Options (`buildOptionsForm`)
- **Multiple values** (`multiple`): `or` (`implode('+')`), `and` (`implode(',')`), or
  `ignore` (first value only). For OR/AND also tick *Allow multiple values* in the More group.
- **Override** — `overridden_entity_type` / `overridden_field_name` for when the route
  parameter or field name differs from the view's contextual filter.
- **Use parent as argument** (`use_parent_term`) — for taxonomy: replace each term value
  with its parent term ids via `TermStorage::loadAllParents()` (pairs with
  `taxonomy_index_tid_depth`).

## Configuration recipe
Add the entity field as a contextual filter → *When the filter is NOT available* → choose
*Same field value from route context* → pick multiple-value handling → set validation to
*Display all results for the specified field* if the filter is optional.

Cache: `getCacheContexts()` = `['url']`, `getCacheMaxAge()` = permanent.
