<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Layout Components — layout plugins, LB overrides, render & clipboard

## Layout plugins (`layoutcomponents.layouts.yml`)

Six definitions — `layoutcomponents_one_column`, `_two_column`, `_three_column`, `_four_column`,
`_five_column`, `_six_column` — all sharing:

- `class: \Drupal\layoutcomponents\Plugin\Layout\LcBase` (extends core `LayoutDefault`,
  implements `ContainerFactoryPluginInterface`; ctor takes `LcLayoutsManager` + `ConfigFactory`).
- `template: templates/layout--layoutcomponents-base`, `category: Layout Components`.
- Bootstrap regions with `col-sm-12/6/4/3/2` classes; `default_region: first`.

`LcBase` builds the whole per-section configuration form: `defaultConfiguration()` seeds settings
from the `layoutcomponents.section`/`.column` config objects; `buildConfigurationForm()` +
`setAdminsitrativeSection()`, `setAdminsitrativeRegion()`, `setAdministrativeTitle()` assemble the
section/column/title styling controls (background, borders, radius, paddings, sizing, height,
alignment, extra class/attributes, role visibility, `section_overwrite`/`section_label`/
`section_delta`). `submitConfigurationForm()`/`validateConfigurationForm()` persist them.

## Core Layout Builder overrides (`Routing\LcRouteSubscriber::alterRoutes()`)

Swaps controllers/forms on core routes (requirements kept — core's `_layout_builder_access` etc.
still gate them):

- `layout_builder.choose_block` → `Controller\LcChooseBlockController::build`
- `layout_builder.choose_inline_block` → `LcChooseBlockController::inlineBlockList`
- `layout_builder.choose_section` → `Controller\LcChooseSectionController::build`
- `layout_builder.add_block` → `Form\LcAddBlockForm`
- `layout_builder.update_block` → `Form\LcUpdateBlockForm`
- `layout_builder.configure_section` → `Form\LcConfigureSection`
- `layout_builder.remove_section` → `Form\LcRemoveSection`
- `layout_builder.remove_block` → `Form\LcRemoveBlock`

Also, `plugin.manager.element_info` is overridden by `LcElementInfoManager`, which replaces the core
`layout_builder` render element class with `Element\LcElement` (the LC administrative builder: adds
section links, tooltips, per-region/-block admin controls; ctor pulls tempstore, `LcLayoutsManager`,
`LcSectionManager`, config, current user).

## Own routes (`layoutcomponents.routing.yml`)

Builder-facing (all `_layout_builder_access: 'view'`, `_admin_route`, `section_storage` from
`layout_builder_tempstore`):

- `layoutcomponents.update_column` — `/layout_builder/configure/column/{…}/{delta}/{region}` →
  `Form\LcUpdateColumn` (column configure form).
- `layoutcomponents.copy` (`/layoutcomponents/copy`) → `Form\LcCopy`; `.copy_remove`,
  `.copy_block`, `.copy_column`, `.copy_section` → the matching `Form\LcCopy*`. These write the
  copied element into the per-user **private tempstore** collection `lc` key `lc_element`.

Utility controllers:

- `layoutcomponents.getclipboard` — `/layoutcomponents/clipboard`, permission `lc clipboard`,
  `LcClipboardController::getElement()` returns the caller's own `lc`/`lc_element` tempstore as JSON
  (paste source for the JS clipboard).
- `layoutcomponents.getmedia` — `/layoutcomponents/media/{id}`, permission `access content`,
  `LcInlineMedia::getMedia($id)` returns `{uri}` for a media entity's `field_media_image` file.

Copy/paste mechanics: `LcChooseBlockController::build()` checks `lc_element`; if a block was copied
it calls `LcLayoutsManager::duplicateBlock()` (also `duplicateColumn()`, `duplicateSection()`,
`checkUuid()` for fresh UUIDs), writes the section storage back to tempstore, and closes via
`rebuildAndClose()`. `LcSectionManager` reads a section's LC settings/id and detects sub-sections.

## Render pipeline

`layoutcomponents.theme.inc::_layoutcomponents_preprocess_layout()` dispatches
`LcPreprocessLayoutEvent` (`layoutcomponents_preprocess_layout`) with the `layoutcomponents.render`
service (`LcLayoutRender`), then calls `$layout->render([...])` and attaches
`drupalSettings['lc']`. `LcLayoutRender` (`getSetting/setSetting`, `setColumn`, `setColumnTitle`,
`setSectionTitle`, `parseAttributes`) turns stored section/column settings into wrapper markup,
inline styles, background image/video (Media view builder), classes and attributes. `LcTheme`
provides `hook_theme`, theme suggestions (`layout__layoutcomponents_base__…`) and the block-content
suggestion/preprocess; `LcEntity` handles block_content view/type-form/inline-entity-form alters and
`entity_type_alter`; `LcPage` handles `page_attachments`/`library_info_alter`.

Libraries (`*.libraries.yml`): `layoutcomponents` (js/layoutcomponents.js, parallax), `.editform`,
`.lateral`, `.lateral-column`. `hook_block_view_alter` hides the core breadcrumb block on
`layout_builder.*` routes.
