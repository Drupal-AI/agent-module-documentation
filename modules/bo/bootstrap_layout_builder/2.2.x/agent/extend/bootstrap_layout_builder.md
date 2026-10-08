# Extend Bootstrap Layout Builder

BLB is driven by three config entity types plus one core Layout plugin. You extend it by adding
config entities (UI or config export), not by writing new plugin classes.

## How layouts are generated (the deriver)

`BootstrapLayout` (`src/Plugin/Layout/BootstrapLayout.php`, `@Layout id = "bootstrap_layout_builder"`)
declares `deriver = BootstrapLayoutDeriver`. The deriver (`src/Plugin/Deriver/BootstrapLayoutDeriver.php`)
loads every `blb_layout` config entity (sorted by `number_of_columns`) and emits one core
`LayoutDefinition` per entity:

- `id` = the layout entity id, `label` = its label, `category` = `Bootstrap`.
- `regions` = `blb_region_col_1 … blb_region_col_N` (N = `number_of_columns`), labelled "Col 1"…"Col N".
- `theme_hook` = `blb_section`; `icon_map` = a row of `square_one … square_twelve` icons.

So **adding a new column layout = create a `blb_layout` entity** (id, label, `number_of_columns`).
A new Layout plugin derivative appears automatically after a plugin cache clear. There is **no new
plugin manager** and no `*.api.php` — do not implement custom BLB hooks; there are none.

## Config entity model

| Entity | Interface | Key properties |
|---|---|---|
| `blb_breakpoint` | `BreakpointInterface` | `base_class` (Bootstrap prefix, e.g. `col-lg`), `weight`; `getLayoutOptions()`, `getClassByPosition()` |
| `blb_layout` | `LayoutInterface` | `number_of_columns`; `getNumberOfColumns()` |
| `blb_layout_option` | `LayoutOptionInterface` | `layout_id`, `structure` (space-separated column widths, e.g. `6 6`), `breakpoints`, `default_breakpoints`, `weight`; `getStructureId()`, `getDefaultBreakpointsIds()` |

Column CSS classes are computed at render time from a breakpoint's `base_class` + the option's
`structure` position — e.g. breakpoint `col-lg` with structure `3 9` yields `col-lg-3` / `col-lg-9`.

### Add a custom breakpoint

Create a `blb_breakpoint` (UI: `/admin/config/bootstrap-layout-builder/breakpoints/add`, or config):

```yaml
# bootstrap_layout_builder.breakpoint.xl.yml
id: xl
label: 'Extra large'
base_class: col-xl
weight: -6
```

### Add a custom column split (layout option)

```yaml
# bootstrap_layout_builder.layout_option.blb_col_3_2_8_2.yml
id: blb_col_3_2_8_2
layout_id: blb_col_3      # must match an existing blb_layout
label: 'Narrow / Wide / Narrow'
structure: '2 8 2'        # widths per column, sums to 12
breakpoints:              # which breakpoints may offer this option
  desktop: desktop
  tablet: tablet
  mobile: mobile
default_breakpoints:      # breakpoints where it is preselected
  desktop: desktop
weight: -9
```

## Styling integration (bootstrap_styles)

`BootstrapLayout::build()` delegates all visual styling to the injected
`plugin.manager.bootstrap_styles_group` (`StylesGroupManager`):
`buildStylesFormElements()` renders the **Style** tab, `submitStylesFormElements()` persists it into
`configuration['container_wrapper']['bootstrap_styles']`, and `buildStyles()` applies the stored
styles to the `blb_container_wrapper` theme wrapper at render time. To add background colors, spacing,
etc., extend/configure **bootstrap_styles**, not BLB. The Style tab's available plugins are filtered by
the `bootstrap_layout_builder.styles` config object.

## Theming

`hook_theme()` defines three templates (in `templates/`), overridable in your theme:

- `blb_section` — the section (`base hook` = core `layout`); the derived layouts' `theme_hook`.
- `blb_container` — the inner container (`container` / `container-fluid` / `w-100`).
- `blb_container_wrapper` — outer wrapper that carries background styles.

`bootstrap_layout_builder_preprocess_blb_section()` preprocesses the section variables. Rendering
adds `#theme_wrappers` (`blb_container` inside `blb_container_wrapper`) only when a container type is set.
