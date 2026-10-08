<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# UI Styles Layout Builder — agent index

Adds UI Styles selectors to Layout Builder for three targets: the **section**, each **region**
in a section, and each **block component**. No routes/permissions/settings form; state lives in
the Layout Builder `Section`/`SectionComponent` third-party settings (in an entity override or in
`core.entity_view_display.*` defaults).

- **Section, region and component storage keys + how to set them** →
  [configure/layout-builder-styles.md](configure/layout-builder-styles.md)

Key facts:
- Section third-party (`Section::setThirdPartySetting('ui_styles', ...)`):
  `selected` (section styles), `extra` (section extra classes), `regions` (map: region →
  `{selected, extra}`). Schema `layout_builder.section.third_party.ui_styles`.
- Block component: `SectionComponent` keys `ui_styles_*` (selected) and `ui_styles_*_extra`.
- Classes injected at render by `BlockComponentRenderArraySubscriber`, `EntityViewAlter`,
  `PreprocessBlock` via `StylePluginManager::addClasses()`.
