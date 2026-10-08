<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Component Builder — entity types & access

Three entity types (`src/Entity/`). All content entities use the `entity` contrib module's access stack:
`access = Drupal\entity\EntityAccessControlHandler`, `permission_provider = Drupal\entity\EntityPermissionProvider`,
`query_access = ...QueryAccessHandler`, `permission_granularity = "bundle"`. Both content types are
revisionable (`show_revision_ui = TRUE`), translatable, publishable (`EntityPublishedTrait`) and owned
(`EntityOwnerTrait`), and declare a `content_moderation` handler.

## component_wrapper (content entity)

`admin_permission = "administer component_wrapper"`. `bundle_label` "Component Wrapper type" but has **no
bundle entity** — every wrapper is the same base type; its "kind" comes from the `component_type` reference.
Links under `/admin/structure/component-wrapper*` (route provider `entity\Routing\AdminHtmlRouteProvider`),
canonical `/component-wrapper/{component_wrapper}`. Base fields (`baseFieldDefinitions`):

- `title` (string, default "Untitled", required, label), `component_type` (entity_reference →
  `taxonomy_term` in vocabulary `component_types` — this selects which component plugin/template renders).
- Booleans: `display_title`, `display_header`, `display_footer`, `display_image`, `display_in_region`,
  `custom_styles`.
- `field_image` (image, unlimited, public scheme, png/jpg/jpeg).
- `field_region` (string), `field_weight_in_region` (int) — used when `display_in_region` renders the
  wrapper into a theme region on node view.
- `field_header`, `field_footer` (string_long) — rendered in the wrapper template via `#markup`.
- `field_left_column` / `field_middle_column` / `field_right_column` (entity_reference →
  `component_wrapper`, unlimited, `inline_entity_form_complex` widget) — nested wrappers (composite layout).
- `field_properties` (string_long) — JSON blob of per-instance style options; decoded in preprocess to build
  CSS class names (`key--prop--value`) and read by plugins like BubbleMap for display counts.
- `field_display_mode` (string) — view mode applied to child references.
- `uid`, `created`, `changed`, `status`.

The item field for a given type is `field_<template_machine_name>` (`getItemFieldName()`), e.g. a "tabs"
wrapper stores its items in `field_tabs`.

## component_item (content entity)

`admin_permission = "administer component_item"`. **Bundled** by `component_item_type` (config entity,
`bundle_entity_type = "component_item_type"`); one bundle is created per activated component type.
`label` key = `admin_title`. Fields on each bundle are created by the config import from the component's yml
(e.g. `field_button_link`, `field_cells`, `title`, image/media fields, …). Canonical
`/component-item/{component_item}`, admin routes under `/admin/structure/component-item*`.

## component_item_type (config entity)

Bundle definition for `component_item`. Access handler `entity\BundleEntityAccessControlHandler`. Managed at
`/admin/structure/component-item` (Field UI base route `entity.component_item_type.edit_form`).

## Permissions

- Declared in `component_builder.permissions.yml`: **`view any unpublished component_item`**.
- Synthesized per bundle by `EntityPermissionProvider` for each content type, e.g.
  `administer component_wrapper`, `create <bundle> component_wrapper`, `update any component_wrapper`,
  `view component_wrapper`, `view own unpublished component_wrapper`, and the equivalent
  `... component_item` set. `administer <type>` is the restricted super-permission for each.
- The **settings form** (`ComponentItemSettingsForm::submitForm`) grants `view component_wrapper` and
  `view component_item` to the **anonymous and authenticated** roles once (`grant_permissions` flag in
  `component_builder.settings`), so activated components are viewable by site visitors.

## Uninstall

`hook_uninstall` deletes the `component_types` vocabulary and the `component_item.component_item_setting`
config. `hook_update_8210`–`8216` added `field_image`, `display_image`, `field_header`/`field_footer`,
`custom_styles`, and title/status tweaks to `component_wrapper`/`component_item`.
