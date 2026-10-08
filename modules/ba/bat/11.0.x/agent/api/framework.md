# BAT base framework API

The base `bat` module (`bat.module`) provides the cross-cutting services the whole suite reuses.

## Entity-access model — `bat_entity_access($entity, $operation, $account)`

`hook_entity_access()` implementation (in `bat.module`) that applies to these entity types only:
`bat_type_group`, `bat_unit`, `bat_unit_type`, `bat_event`, `bat_event_series`, `bat_booking`.
Each functional module's `<mod>_<entity>_access()` helper just delegates here. Decision order:

1. `bypass <entity_type> entities access` (a **restricted** permission) → allow everything.
2. **view**: if any module implements `hook_query_<type>_alter` / `hook_query_<type>_access_alter`,
   run a tagged 1-row DB probe (tags `<type>`, `<type>_access`, metadata `account`) and allow only
   if it returns a row; otherwise allow view unconditionally.
3. **non-view**: invoke `hook_bat_entity_access()` on all modules — any `FALSE` forbids, else any
   `TRUE` allows (this overrides role permissions; see hooks doc).
4. **create**: allow if `create <type> entities` OR `create <type> entities of bundle <bundle>`.
5. **update/delete**: allow if `<op> any <type> entity` / `… of bundle <bundle>`; else, for an
   entity with an owner, `<op> own <type> entities` / `… of bundle <bundle>` when
   `getOwnerId() === $account->id()`.
6. Otherwise forbidden.

Results are statically cached per account/entity/operation.

## Listing filter — `bat_entity_access_query_alter($query, $entity_type, $base_table, $account, $op)`

The Views/entity-query counterpart of the access model. Skips users with `bypass …` or
`<op> any <type> entity`. Otherwise builds an `OR` of conditions per bundle
(`<op> any … of bundle <b>`, or an owner-scoped AND for `<op> own … of bundle <b>`, plus
`<op> own … entities`). Fires alter hooks
`bat_entity_access_<op>_condition_<type>` and `bat_entity_access_<op>_condition`. If no condition
matched, the query is falsified (`1 = 0`) — view checks grant, they never merely fail open.

## Permission generator — `bat_entity_access_permissions($entity_type)`

Returns the full permission array a BAT entity type exposes; submodules call it from their
`permission_callbacks`. For a type with label `L` it produces:
`bypass <type> entities access` (restricted), `create <type> entities`,
`view own <type> entities`, `view any <type> entity` (restricted),
`update own <type> entities`, `update any <type> entity` (restricted),
`delete own <type> entities`, `delete any <type> entity` (restricted), and a per-bundle
`create/view own/view any/update own/update any/delete own/delete any … of bundle <b>` set
(the `any` variants are `restrict access: TRUE`). Owner-scoped perms are only emitted when the
entity declares a `uid` key.

## Date handling

- **`bat_date` param converter** (`DateParamConverter`, service `bat_date`): a route parameter
  declared `type: bat_date` is `Html::escape()`d then passed to `new \DateTime(...)`; on parse
  failure the value becomes `0`. Used by the fullcalendar management route's `start_date`/`end_date`.
- **`bat_date_range_fields($year, $month, $granularity)`**: returns a `bat_start_date` + `bat_end_date`
  pair of `#type => date` render elements with shared `bat-min`/`bat-max` attributes and the
  `bat/bat_date_range` JS library attached. Bounds come from `bat.settings`
  (`bat_daily_date_format`, `bat_event_start_date`); if `$year`+`$month` given, bounds are that month.

## Type-group helpers (`bat_type_group` entity)

`bat_type_group_load($id, $reset)`, `bat_type_group_load_multiple($ids, $conditions, $reset)`
(entity query with `accessCheck(TRUE)`), `bat_type_group_save($group)`, `bat_type_group_create($values)`,
`bat_type_group_delete($group)` / `_delete_multiple($ids)`, `bat_type_group_get_bundles($name, $reset)`,
`bat_type_group_bundle_load($bundle, $reset)`.

## Display helper — `bat_get_entity_display($entity_type, $bundle, $display_context)`

Loads (or creates if missing) the `entity_view_display` / `entity_form_display` for
`<type>.<bundle>.default`. `$display_context` must be `view` or `form` (else `InvalidArgumentException`).
Ported from Commerce's `commerce_get_entity_display`.

## Theme / toolbar

`hook_theme()` defines `bat_type_group_add_list` and `bat_entity_edit_form`. `hook_toolbar()` adds a
`bat` toolbar item (library `bat/drupal.bat.toolbar`).
