<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Display Builder for page layout (display_builder_page_layout) — agent index

Adds whole-page layouts built with [Display Builder](../../../1.x/agent/start.md). Depends on
`display_builder:display_builder`. Core `^11.3`. Package **User interface**. Part of the
`display_builder` project.

## What it provides (from source)

- **`page_layout` config entity** (`src/Entity/PageLayout.php`, interface `PageLayoutInterface`,
  list builder `PageLayoutListBuilder`, form `Form/PageLayoutForm`). Config schema in
  `config/schema/`.
- **Routes** (`display_builder_page_layout.routing.yml`) under `/admin/structure/page-layout`:
  collection, add, add-default (with `_custom_access:
  DefaultPageLayoutAccess::access`), edit, delete, duplicate, and the **builder** route
  `entity.page_layout.display_builder` (`…/{page_layout}/builder`,
  `PageLayoutController::getBuilder`, `_display_builder_full_page_route: true`). All gated by
  `administer page_layout`.
- **Permission** (`display_builder_page_layout.permissions.yml`): `administer page_layout`.
- **Buildable plugin**: `Plugin/display_builder/Buildable/PageLayout`.
- **Display variant**: `Plugin/DisplayVariant/PageLayoutPageVariant` + `EventSubscriber/
  PageVariantSubscriber` — makes Drupal render matching pages through the layout.
- **UI Patterns sources** (`src/Plugin/UiPatterns/Source/`): `PageTitleSource`,
  `MainPageContentSource`, `PageLayoutSource`; base `Plugin/PageRegionSourceBase`.
- **Controller** `PageLayoutController` (extends `IntegrationControllerBase`): `getBuilder`,
  `getTitle`, `duplicate`.
- **Access** `Access/DefaultPageLayoutAccess`. **Service** `builder_data_converter`
  (`BuilderDataConverter`, seeds a layout from theme block placements). **`StartingPointType`**.
  Templates `templates/page.html.twig`, `templates/region.html.twig`. Links menu/action.

## Notes

- The builder screen and all CRUD require `administer page_layout` (an admin-level permission).
- `PageVariantSubscriber` selecting the variant is what makes a saved layout actually take over
  page rendering; the base module's `FullPageVariantSubscriber` handles the full-page preview.
