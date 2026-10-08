<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Autocomplete route, controller & param converter

## Route (`views_autocomplete_api.routing.yml`)
- **id** `views_autocomplete_api`
- **path** `/admin/view_content/{view_name}/{display_id}/{views_arguments}`
- **defaults**: `_controller: ViewsAutocompleteApiController::getViewsDataJson`, `_title: 'View Autocomplete'`,
  `display_id: 'default'`, `views_arguments: ''`
- **options.parameters.view_name.type**: `views-autocomplete-api-views` (activates the param converter)
- **requirements**: `_permission: 'access content'`

The typed text is **not** a path segment — it arrives as the `?q=` query string, which is what core's
autocomplete JS appends. So a real request looks like
`/admin/view_content/my_view/default/?q=jo`.

## Multi-View request format
All three path parameters are comma-lists indexed positionally across the Views:
- `view_name`: `view1,view2` — machine names.
- `display_id`: `,block_1` — per-View display id; empty entry falls back to `default`.
- `views_arguments`: `a&b,c` — comma splits per View, `&` splits multiple contextual args for one View.
The controller/manager `warning`-log when the counts don't line up but still proceed.

## Param converter — `ViewsConverter` (`src/ParamConverter/ViewsConverter.php`)
- Service `views_autocomplete_api.converter`, tag `paramconverter`, arg `@entity_type.manager`.
- `applies()` returns TRUE only for `$definition['type'] === 'views-autocomplete-api-views'`.
- `convert()` `explode(',', $value)`, builds `array_fill_keys($names, '')`, then `array_merge`s the result
  of `view` storage `loadMultiple($names)`. Net: `{view_name}` becomes an **array keyed by machine name**;
  ids that don't resolve stay as `''` (empty string) so the controller can log "can't load" and skip them.

## Controller — `ViewsAutocompleteApiController::getViewsDataJson()` (`src/Controller/…`)
Signature `(array $view_name, $display_id, $views_arguments, Request $request)`.
1. `$search = $request->query->get('q')`. If `$search` **or** `$view_name` is empty → log error, return
   `new JsonResponse([])`.
2. `getViewsDisplayId($display_id, count($view_name))` and `prepareArgumentViews($views_arguments, …)`
   normalize the per-View display ids / args (see api/manager.md).
3. Loop the loaded Views; skip (and log) empty entries; default a missing display id to `default`;
   call `$manager->executeViews($view, $display_id, $search, $view_data, $args)` which **appends** to
   `$view_data` by reference.
4. Return `new JsonResponse($view_data)` — a flat array of `{value, label}` objects (plus any rendered
   header/footer/empty strings the manager unshifted/appended).

Built from `ControllerBase`; logs to channel `views_auto_complete_api`. `create()` injects only
`views_autocomplete_api.manager`.
