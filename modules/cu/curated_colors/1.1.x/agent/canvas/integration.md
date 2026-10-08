<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drupal Canvas / SDC integration

Curated Colors integrates with **Drupal Canvas** (`drupal/canvas`, a dev/suggest dependency — no
runtime requirement) so the swatch picker appears in Canvas's component editor for annotated SDC
props. All integration lives in `curated_colors.module` and is gated on Canvas being installed.

## Annotating an SDC prop

Add the JSON Schema vendor extension **`x-curated-color-palette`** to any `type: string` prop; its
value is a palette id (or `''` for the default):

```yaml
# my_component.component.yml
props:
  type: object
  properties:
    color:
      title: 'Accent color'
      type: string
      x-curated-color-palette: brand   # palette id; '' = use the resolved default
      examples:
        - brand-blue
```

The picker then renders in Canvas both when the prop is **bound to a `curated_color` field** and
when an editor sets the value **statically** on a Canvas page. Components need no hardcoded palette
id as long as the site has at least one palette.

> Why a `x-*` key and not a custom `format`? Canvas resolves `format` against a sealed PHP enum
> (`JsonSchemaStringFormat::from()`) and throws on unknown values *before* any alter hook runs, so a
> custom format would crash Canvas. JSON Schema reserves `x-*` for vendor extensions and Canvas's
> interpreter ignores them, letting the prop fall through to where the hook below can override it.

## `hook_canvas_storable_prop_shape_alter()`

For a `type: string` prop that has an `x-curated-color-palette` key, the hook:

1. resolves the palette id via `curated_colors.palette_resolver`::`resolveForCanvas()` — order:
   the annotation value (if the palette exists) → a palette id `canvas` → the alphabetically-first
   palette; NULL (do nothing, default string handling) if no palettes exist;
2. sets `fieldTypeProp` to `FieldTypePropExpression('curated_color', 'value')`, `fieldWidget` to
   `curated_color_picker`, and `fieldInstanceSettings` to `['palette' => <resolved id>]`.

## `hook_field_widget_info_alter()`

Registers the Canvas transform for the widget: `curated_color_picker`'s `canvas.transforms` is set
to `['mainProperty' => ['name' => 'value']]`, mapping the widget's single `<select>`
(`field_name[0][value]`) back to the SDC prop value.

## Field discoverability (`StringSemantics: prose`)

Separately, `CuratedColorItem::propertyDefinitions()` adds a `StringSemantics: prose` constraint to
the `value` property **when Canvas is installed**. Canvas's `EntityFieldPropSourceMatcher` gates
bare-string prop matches on that constraint, so without it the field would be invisible in Canvas's
content-template field-binding dropdown. Trade-off noted in source: the field is also then offered
for unrelated bare-string props (titles, captions), because a tighter entity-field match hook does
not yet exist in Canvas.

## Worked example

The `curated_colors_example` submodule ships a `colored_card` SDC component whose `color` prop is
annotated `x-curated-color-palette: drupal_brand`, applying the chosen key as a CSS modifier class
(`colored-card--drupal-blue`). See
[the example submodule](../../../modules/curated_colors_example/1.1.x/agent/start.md).
