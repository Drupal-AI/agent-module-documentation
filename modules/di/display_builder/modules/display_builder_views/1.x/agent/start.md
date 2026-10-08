<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Display Builder for Views (display_builder_views) — agent index

Associates [Display Builder](../../../1.x/agent/start.md) with Views displays. Depends on
`drupal:views`, `display_builder:display_builder`, `ui_patterns:ui_patterns_views`. Core `^11.3`.
Package **User interface**. Part of the `display_builder` project.

## What it provides (from source)

- **Views display extender**: `Plugin/views/display_extender/DisplayExtender`. On install
  (`display_builder_views.install`) `display_builder` is appended to `views.settings`
  `display_extenders` (and removed on uninstall), so view displays can opt into Display Builder.
- **Buildable plugin**: `Plugin/display_builder/Buildable/ViewDisplay` (+ `ViewsBuilderSourceTrait`).
- **Routes** (`display_builder_views.routing.yml` + dynamic `src/Routing/DisplayBuilderRoutes`):
  - `display_builder_views.views.manage` — `/admin/structure/views/view/{view}/display-builder/{display}`,
    `ViewsController::getBuilder`, requirements `_entity_access: view.update`, `_permission:
    administer views`, `_module_dependencies: views_ui`, `_display_builder_full_page_route: true`
    (uses the Views UI tempstore param converter).
  - `display_builder_views.views.collection` — `/admin/structure/views/display-builder`
    (`ViewsManagementController::pageViewsIndex`, `administer views`).
  - `display_builder_views.views.delete` — confirm form `ConfirmViewsBuilderDeleteForm`.
- **UI Patterns sources** (`src/Plugin/UiPatterns/Source/`) for each Views output region:
  `ViewRowsSource`, `ViewHeaderSource`, `ViewFooterSource`, `ViewEmptySource`, `ViewPagerSource`,
  `ViewMoreSource`, `ViewFeedIconsSource`, `ViewExposedSource`, `ViewAttachmentBeforeSource`,
  `ViewAttachmentAfterSource`.
- **Hooks** (`src/Hook/`): `DisplayBuilderViewsHook`, `PreprocessViewsView`. Template
  `templates/views-view.html.twig`. Config schema in `config/schema/`. Services: `routes` (route
  subscriber) and `display_builder_views_hook`.

## Notes

- Access uses core `administer views` plus per-view `update` access — no new permission.
- The builder screen loads the view from the Views UI temp store (param converter
  `paramconverter.views_ui`), so it behaves like the rest of the Views UI edit session.
