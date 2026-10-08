# Behaviour, hooks and service API

All logic lives in the `EetHooks` service (`Drupal\entity_editor_tabs\EetHooks`), invoked from two
procedural hooks in `entity_editor_tabs.module`. There is nothing to configure — behaviour is derived
per entity-type/bundle from whether Content Moderation moderates the bundle and whether Layout Builder
overrides are enabled on it.

## Hooks implemented

| Hook | Method | Effect |
|---|---|---|
| `hook_local_tasks_alter(&$localTasks)` | `EetHooks::hookLocalTasksAlter()` | Re-weights + swaps tab plugin classes/titles. |
| `hook_entity_operation_alter(&$operations, $entity)` | `EetHooks::hookEntityOperationAlter()` | Retitles entity operation links. |

Both short-circuit unless `layout_builder` or `content_moderation` is installed.

## Tab reordering

For every entity-type/bundle it resolves the local-task IDs for the `canonical`, `latest-version`,
`edit-form`, `delete-form` link templates (via the `entity_route_context.route_helper` service) plus
the Layout Builder override task `layout_builder_ui:layout_builder.overrides.<entityType>.view`. It then
enforces this order — **View, Latest version, Edit, Layout, Delete** — bumping weights only where needed
and **never** changing the canonical (View) tab's weight.

## Layout Builder customization (when `isLayoutBuilderOverridable()`)

- Edit tab (`edit-form` local task) → `class` set to `EetUpdateLocalTask`.
- Layout override tab title → `t('Edit content')`.
- Operation link on the edit-form route → title `Edit metadata`.
- Operation link on `layout_builder.overrides.<entityType>.view` route → title
  `Edit <entity singular label>` (e.g. "Edit content item" for nodes).

## Content Moderation customization (when the bundle is moderated)

- View tab (`canonical`) → `class` `EetCanonicalLocalTask`.
- Latest-version tab → `class` `EetLatestLocalTask`.
- `EetCanonicalLocalTask::getTitle()` returns `View <state label>` computed from the **default
  revision's** moderation state — but only when the viewed entity is *not* the live revision (i.e. a
  newer forward/draft revision exists). Otherwise it falls back to the default tab title. Cache tags
  include the entity's cache tags; a `route` cache context is added.

## Utility service

`Drupal\entity_editor_tabs\EetUtility::isLayoutBuilderOverridable(string $entityTypeId, string $bundle): bool`
— queries `entity_view_display` config for `third_party_settings.layout_builder.allow_custom = TRUE` on
that bundle. Both `EetHooks` and `EetUtility` are declared `public` in
`entity_editor_tabs.services.yml`, so you can fetch them with `\Drupal::service(EetUtility::class)`.

## Custom local-task plugins

`EetCanonicalLocalTask`, `EetLatestLocalTask`, `EetUpdateLocalTask` extend core `LocalTaskDefault` and
share `EetLocalTaskTrait::getEntity()`, which resolves the route entity from the
`@entity_route_context.entity_route_context:canonical_entity` runtime context (falling back to the base
route's entity parameter). You do not instantiate these — the module assigns them as tab `class`es.
