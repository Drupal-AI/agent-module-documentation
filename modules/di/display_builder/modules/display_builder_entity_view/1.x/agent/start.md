<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Display Builder for entity view (display_builder_entity_view) — agent index

Integrates [Display Builder](../../../1.x/agent/start.md) with Drupal entity view displays.
Depends on `drupal:field_ui`, `display_builder:display_builder`,
`ui_patterns:ui_patterns_field`, `ui_patterns:ui_patterns_field_formatters`. Core `^11.3`.
Package **User interface**. Part of the `display_builder` project.

## What it provides (from source)

- **Buildable plugins** (`src/Plugin/display_builder/Buildable/`): `EntityView` (build a bundle's
  view-mode display) and `EntityViewOverride` (build/override a single entity's display).
- **Config entities** (`src/Entity/`): `EntityViewDisplay` (extends core's entity view display) and
  `LayoutBuilderEntityViewDisplay` (a Layout-Builder-shaped variant used to migrate LB configs);
  interface `DisplayBuilderEntityDisplayInterface`, traits `EntityViewDisplayTrait`,
  `EntityDisplayLabelTrait`. Config schema in `config/schema/`.
- **Dynamic routes** (`src/Routing/`): `DisplayBuilderRoutes` (Manage-display builder route per
  entity type/bundle/view mode) and `OverridesRoutes` (per-entity override builder route), both
  registered as `event_subscriber` route subscribers. Controllers `EntityViewController` and
  `EntityViewOverridesController` (extend `IntegrationControllerBase`), gated by the underlying
  display's own access; rendered on a `_display_builder_full_page_route`.
- **Local task derivative**: `Plugin/Derivative/EntityOverrideViewLocalTask` +
  `display_builder_entity_view.links.task.yml` add the "Display builder" tab.
- **Forms** (`src/Form/`): `EntityViewDisplayForm`, `LayoutBuilderEntityViewDisplayForm`, traits
  `EntityViewDisplayFormTrait`.
- **UI Patterns source**: `ExtraFieldSource` (exposes the display as an extra field).
- **Hooks** (`src/Hook/`): `DisplayBuilderEntityViewHook`, `Navigation`, `TemplateOverride`;
  `display_builder_entity_view.module` implements `hook_preprocess_entity` to populate the
  `content` variable for `entity.html.twig`.
- Service `builder_data_converter` (`BuilderDataConverter`) converts display config to builder
  source data; route subscribers `routes` and `overrides_routes`.

## Notes

- Access is delegated to the wrapped entity view display (the `entity_view` buildable's static
  `checkAccess()` via `InstanceAccessControlHandler`), so a user needs the usual display/field-UI
  and entity access, not a new permission.
- Migration from Layout Builder is covered by the Functional tests
  (`LayoutBuilderConfigMigrationTest`, `LayoutBuilderOverrideMigrationTest`).
