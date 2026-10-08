<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Style sections, regions and components in Layout Builder

Enable with `drush en ui_styles_layout_builder` (needs `layout_builder` + `ui_styles`). No
route, permission or settings form; the selectors are injected into the existing Layout
Builder configure forms and stored on `Section` / `SectionComponent` objects.

## Section and its regions

`FormLayoutBuilderConfigureSectionAlter::formAlter()` adds to the "Configure section" off-canvas
form:

- **Section styles** → `ui_styles_styles` element `ui_styles.section`.
- **\<Region\> region styles** → one `ui_styles_styles` per region the layout declares
  (`getLayout()->getPluginDefinition()->getRegions()`).

`submitForm()` (unshifted before Layout Builder's own submit) writes onto the `Section`
third-party settings under provider `ui_styles`, unsetting empties:

```
Section third_party_settings.ui_styles:
  selected: { background: bg-primary }   # section styles
  extra: 'py-5'
  regions:
    first:  { selected: {...}, extra: '' }
    second: { selected: {...}, extra: '' }
```

Schema `layout_builder.section.third_party.ui_styles` (a `ui_styles.selected_mapping` plus a
`regions` sequence of mappings). If the section layout is a UI Patterns 2 component
(`layout id` starting `ui_patterns:`), the section field shows a note to use the component's
`attributes` prop and **no** region fields are added.

## Block component

`FormLayoutBuilderBlockAlter::formAlter()` adds three `ui_styles_styles` fields to a block's
configure form and `submitForm()` stores them **flat** on the `SectionComponent` (values are
kept flat for backward compatibility):

| form key / component key | title | `_extra` key | render target |
|---|---|---|---|
| `ui_styles_wrapper` | Block styles   | `ui_styles_wrapper_extra` | block wrapper |
| `ui_styles_title`   | Title styles   | `ui_styles_title_extra`   | block title (hidden if label off) |
| `ui_styles`         | Content styles | `ui_styles_extra`         | block content |

`$component->set('ui_styles_wrapper', $selected)` / `set('ui_styles_wrapper_extra', $extra)`,
etc.

## Render

Classes are applied by `StylePluginManager::addClasses()` from several handlers:
`BlockComponentRenderArraySubscriber` (component build), `EntityViewAlter` (section wrappers on
the entity view), `PreprocessBlock` (block parts), with
`LayoutBuilderTrustedCallbacks`/`ElementInfoAlter` registering the render callbacks. Storage
lives in the entity override (custom layout) or in the default
`core.entity_view_display.<entity_type>.<bundle>.<view_mode>`.
