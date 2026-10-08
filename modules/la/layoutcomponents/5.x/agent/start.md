<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Layout Components (layoutcomponents) — agent index

Extension of Drupal core **Layout Builder** that rewrites its editing UI and adds a visual
section/column/component builder with live preview. Package `LayoutComponents`. Version
**5.0.0-beta1**. Core `^9 || ^10 || ^11`. License GPL-2.0-or-later. **Parent project only** here —
the ~23 `lc_*` component submodules (accordion, card, tabs, timeline, video, iframe, slick, etc.)
are documented separately.

Heavy dependency surface (info.yml): core `layout_builder`, `ckeditor5`, `field`, `field_group`,
`file`, `filter`, `options`, `text`, `views`, `media`, `media_library`; contrib `linked_field`,
`color_field`, `video_embed_field`, `entity_reference_revisions`, `inline_entity_form`,
`block_form_alter`, `media_library_form_element`, `jquery_ui_slider`, `jquery_ui_tooltip`,
`sliderwidget`, `viewsreference` (composer).

## What it provides (from source)

- **Layout plugins** — `layoutcomponents_one_column` … `_six_column` (`*.layouts.yml`), all class
  `Plugin\Layout\LcBase` (extends core `LayoutDefault`), template
  `templates/layout--layoutcomponents-base`, Bootstrap `col-sm-*` regions, category *Layout
  Components*. → [plugins/layouts.md](plugins/layouts.md)
- **Route/controller/form overrides** of core Layout Builder via `Routing\LcRouteSubscriber` +
  own routes (clipboard copy/paste, column configure, inline media). → [plugins/layouts.md](plugins/layouts.md)
- **Services** (`*.services.yml`): `plugin.manager.layoutcomponents_layouts` (`LcLayoutsManager`),
  `layoutcomponents.render` (`LcLayoutRender`), `layoutcomponents.section` (`LcSectionManager`),
  `layoutcomponents.update` (`LcUpdateManager`), `layoutcomponents.apiComponent` (`Api\Component`),
  `plugin.manager.element_info` (`LcElementInfoManager`, replaces core `layout_builder` render
  element with `Element\LcElement`), `layoutcomponents.route_subscriber`.
- **Config + settings** — five config objects and five settings forms (General, Interface, Colors,
  Section, Column) with schema in `config/schema/layoutcomponents.schema.yml`. →
  [config/settings.md](config/settings.md)
- **Dynamic permissions** — `LcPermissions::getPermissions()` (per-bundle create/move/remove/
  configure/copy of sections, columns, blocks) + five static `default lc * settings` perms and
  `lc clipboard`. → [config/settings.md](config/settings.md)
- **Field plugins** — field type `layoutcomponents_field_reference` (`LcFieldReferenceItem`),
  widget `layoutcomponents_entity_reference` (`LcFieldReferenceWidget`), formatter
  `layoutcomponents_entity_formatter` (`LcFieldReferenceFormatter`). Render element
  `Element\LcElement`, form element `@FormElement("color_field_element_box")` (`Element\LcColorField`).
  → [api/extending.md](api/extending.md)
- **Extension API** — `Api\Component` + `Api\Text/Slider/Media/Select/Color/Checkbox/General`
  build LC-styled form elements for custom components. → [api/extending.md](api/extending.md)
- **Hooks** (`.module`, delegated to `LcTheme`/`LcPage`/`LcEntity` via class_resolver): theme,
  theme_suggestions_alter, page_attachments, library_info_alter, block_content_view_alter,
  preprocess_block, inline_entity_form_entity_form_alter, block_type_form_alter, entity_type_alter,
  block_view_alter. Event `LcPreprocessLayoutEvent` (`layoutcomponents_preprocess_layout`).

No new plugin *types*; no Drush in the parent (Drush lives in the `lc_commands` submodule).
