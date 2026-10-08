<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Routes, "Manage markup" tabs, and hooks

The module defines no static `*.routing.yml`. Routes and local tasks are generated dynamically for
every entity type that exposes a Field UI base route (`field_ui_base_route`).

## Route subscriber `RouteSubscriber`

`src/Routing/RouteSubscriber.php` extends `RouteSubscriberBase`; registered in
`entity_markup.services.yml` as `entity_markup.subscriber` (arg `@entity_type.manager`, tag
`event_subscriber`). `getSubscribedEvents()` binds `RoutingEvents::ALTER` at priority **-100**.

`alterRoutes()` iterates entity type definitions; for each with a `field_ui_base_route` present in the
collection it clones that route's path/options and adds two routes:

- `entity_markup.<entity_type_id>.default` → path `<field_ui_path>/markup`, defaults
  `_form = \Drupal\entity_markup\Form\EntityMarkupEditForm`, `_title = 'Manage markup'`,
  `view_mode_name = 'default'`, `entity_type_id`.
- `entity_markup.<entity_type_id>.view_mode` → path `<field_ui_path>/markup/{view_mode_name}`, same
  `_form`/`_title`.

Both set requirement **`_field_ui_view_mode_access: administer <entity_type_id> display`** (so access is
the core Field UI display permission — the module adds no permission of its own). Options carry
`_field_ui = TRUE` and `_entity_markup = TRUE`; the bundle parameter is upcast when a bundle entity type
exists, and `bundle` is defaulted for entity types with no `{bundle}` in the path.

## Local tasks / tabs

`entity_markup.links.task.yml` declares `entity_markup.fields`
(`class: LocalTaskDefault`, `deriver: EntityMarkupLocalTask`). (It also lists
`entity_markup.markup_mode.edit_form` and `entity_markup.markup_mode.collection`, whose named routes are
not defined by the module — inert leftover entries.)

`src/Plugin/Derivative/EntityMarkupLocalTask.php` (`ContainerDeriverInterface`) builds, per entity type
with a `field_ui_base_route`:

- `markup_overview_<type>` — the **"Manage markup"** tab (route `entity_markup.<type>.default`,
  base route `entity.<type>.field_ui_fields`, weight 3).
- `entity_markup_default_<type>` — a **"Default"** sub-tab under it.
- `entity_markup_<view_mode>_<type>` — one sub-tab per view mode (from
  `entity_display.repository::getViewModes()`), route `entity_markup.<type>.view_mode` with
  `view_mode_name` parameter.

`alterLocalTasks()` (called from `entity_markup_local_tasks_alter()`) rewrites each derived task's
`base_route` to the entity type's real `field_ui_base_route`.

## Hooks (`entity_markup.module`)

- `hook_entity_bundle_create()` → `router.builder->setRebuildNeeded()` so new bundles get the tabs.
- `hook_entity_operation()` → adds a **"Manage markup"** operation (weight 30) on bundle entities whose
  `bundle_of` type has a `field_ui_base_route`, linking to `entity_markup.<bundle_of>.default`.
- `hook_local_tasks_alter()` → invokes the deriver's `alterLocalTasks()` (see above).
- Theme/preprocess hooks that apply the stored markup are covered in
  [../config/markup.md](../config/markup.md).
