<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views Multiple Permissions (views_multiple_permissions) — agent index

Views **access plugin** granting a display by **multiple permissions with AND/OR**. Version **2.0.0**.
Core `>=9.3`.

**Access logic verified correct (positive):** `access()` short-circuits (OR→true on first match,
AND→false on first miss) and the terminal `return $operator === 'and'` handles both fall-through
cases; `alterRouteDefinition()` mirrors it into the route requirement with Drupal's `,`/`+` glue, so
the view is gated consistently at both layers.

**Edge:** an **empty permission list with AND grants everyone** (vacuous truth) — configure the set
deliberately; default is a sensible `access content`.