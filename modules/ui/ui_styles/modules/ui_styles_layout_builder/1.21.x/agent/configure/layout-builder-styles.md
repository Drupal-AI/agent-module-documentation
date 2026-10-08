<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Apply UI Styles in Layout Builder

No dedicated route or settings form — the selectors appear inside Layout Builder's own
"Configure section" and block-component forms. Data is stored on the Layout Builder
`Section` and `SectionComponent` objects, which live in either an entity **override** or the
**default** layout in `core.entity_view_display.<entity>.<bundle>.<mode>`.

## Section and its regions

`FormLayoutBuilderConfigureSectionAlter` adds a `ui_styles_styles` selector for the section
and one per region. Stored on the `Section` third-party settings (`ui_styles` provider):

```php
$section->setThirdPartySetting('ui_styles', 'selected', ['bg' => 'bg-dark']); // section styles
$section->setThirdPartySetting('ui_styles', 'extra', 'ui-styles-eval-section'); // section extra
$section->setThirdPartySetting('ui_styles', 'regions', [                         // per region
  'first'  => ['selected' => [], 'extra' => 'p-3'],
  'second' => ['selected' => ['bg' => 'bg-light'], 'extra' => ''],
]);
```

Config schema: `layout_builder.section.third_party.ui_styles` = a `ui_styles.selected_mapping`
(section `selected`/`extra`) plus a `regions` sequence of `ui_styles.selected_mapping`.
Empty values are unset by the submit handler.

## Block component

`FormLayoutBuilderBlockAlter` adds selectors to a placed block's config. Stored on the
`SectionComponent` with keys `ui_styles_<part>` (the `selected` map) and
`ui_styles_<part>_extra` (the extra string), e.g. `ui_styles_block`, `ui_styles_title`,
`ui_styles_content` (and their `_extra` variants).

## Rendering

Classes are injected via `StylePluginManager::addClasses()` from:
`BlockComponentRenderArraySubscriber` (components), `EntityViewAlter` + `PreprocessBlock`
(sections/regions/blocks), with `LayoutBuilderTrustedCallbacks` and `ElementInfoAlter`
handling deferred processing.

## Inspect a default layout

```bash
drush cget core.entity_view_display.node.page.default third_party_settings.layout_builder.sections
# The ui_styles data is nested inside each serialized Section's third_party_settings.
```
Or load it in PHP: `$display->getThirdPartySetting('layout_builder', 'sections')[0]` then
`->getThirdPartySetting('ui_styles', 'extra')`.
