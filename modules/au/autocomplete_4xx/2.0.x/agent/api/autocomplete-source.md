<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The autocomplete source endpoint

`AutocompleteSourceController` (`src/Controller/AutocompleteSourceController.php`) is an
`__invoke` route controller. Route `autocomplete_4xx.source` →
`/admin/autocomplete_4xx/source`, `_format: json`, requirement `_permission: 'access content'`.
It is the callback wired onto the site 403/404 fields by
`autocomplete_4xx_form_system_site_information_settings_alter()`; the autocomplete widget calls it
with the typed string as query parameter `q`.

## Dependencies (constructor / `create()`)

- `path.validator` → `PathValidatorInterface $pathValidator` (injected but **not used** in the
  current code).
- `router.route_provider` → `RouteProviderInterface $routerRouteProvider`.
- Uses `ControllerBase` helpers `config()` and `entityTypeManager()`.

## Request → response flow (`__invoke(Request $request)`)

1. Reads `$input = $request->query->get('q')`. If empty, returns `new JsonResponse([])` immediately.
2. `$input = Xss::filter($input)` — sanitizes the term before it is used as a query condition.
3. **Node search** (always runs):
   ```php
   $query = entityTypeManager->getStorage('node')->getQuery()
     ->accessCheck(TRUE)
     ->groupBy('nid')
     ->sort('created', 'DESC')
     ->condition('title', $input, 'CONTAINS');
   ```
   If `autocomplete_4xx.settings:content_types` is non-empty, its truthy values are collected into
   `$list` and added as `->condition('type', $list, 'IN')` (bundle filter). The query **runs
   node access checks** (`accessCheck(TRUE)`), then `loadMultiple($ids)`.
4. For each loaded node it appends a suggestion:
   - if `include_unpublished` is on → every returned node is added;
   - else → only `$node->isPublished()` nodes are added.
   Suggestion shape:
   ```php
   ['value' => '/node/' . $node->id(),
    'label' => $node->getTitle() . ' <small>(' . $node->id() . ')</small>']
   ```
   (`value` is what lands in the 403/404 field; `label` is what the dropdown shows.)
5. **Route search** (only when `include_routes` is on): iterates
   `$this->routeProvider->getAllRoutes()` and, for each route whose path matches the input via
   `strpos($route->getPath(), $input)`, appends `['value' => path, 'label' => path]`.
   - If `include_parameterized` is on, parameterized paths are included as-is.
   - Else, paths containing `{` or `}` are skipped (tested with `strpos(...,'{')`/`'}'`).
6. Returns `new JsonResponse($results)` — a flat array of `{value,label}` objects.

## Behavioral caveats (from source, not bugs to "fix" here)

- **`strpos()` truthiness bug (node? no — routes):** step 5 uses `if (strpos($path, $input))` as a
  boolean. `strpos` returns `0` (falsy) when the input matches at the **start** of the path, so a
  route whose path *begins* with the typed text is **not** matched; likewise the `{`/`}` guards in
  step 5 mis-handle a brace at position 0. Node matching in step 3 uses the entity query
  `CONTAINS`, so it is unaffected.
- **Property mismatch:** the constructor stores the route provider in `$routerRouteProvider`, but
  step 5 reads `$this->routeProvider`. This resolves only because `ControllerBase` lazily provides a
  `routeProvider()`/magic accessor path; treat the injected property name as cosmetic.
- **Route suggestions are not access-filtered per route** — unlike the node query, the route branch
  does not check whether the caller may reach each route; it lists paths that match. `include_routes`
  defaults to **FALSE**.
- Node suggestions **respect node access** because of `accessCheck(TRUE)`; `include_unpublished`
  only widens results within what access already allows.
