# `css_grid` layout plugin

The module's whole surface is one Layout Discovery layout plugin. It is declared in
`css_grid.layouts.yml` (YAML discovery, not an attribute/annotation) and backed by a class that
adds a configuration form to the section.

## Definition (`css_grid.layouts.yml`)

```yaml
css_grid:
  label: 'CSS Grid'
  path: templates/layout/css-grid
  template: css-grid            # -> templates/layout/css-grid/css-grid.html.twig
  class: '\Drupal\css_grid\Plugin\Layout\CssGrid'
  category: 'CSS Grid'
  default_region: content
  regions:
    content:
      label: Grid
  icon_map: [...]               # 3x3 preview icon only
```

The single declared `content` region is a placeholder: after the layout is configured, the class
replaces the region map at runtime with `content_1 … content_N` (see "Cells & dynamic regions").

## Class

`Drupal\css_grid\Plugin\Layout\CssGrid extends LayoutDefault implements PluginFormInterface`
(`src/Plugin/Layout/CssGrid.php`).

Unit option sets:
- `gapUnitOptions()` → `%`, `rem`, `px`.
- `defaultUnitOptions()` → `fr`, `auto`, `max-content`, `min-content`, `minmax` **plus** the gap
  units. Used for column/row unit selects.

`defaultConfiguration()` (`:41`):

```php
'grid_cells'  => '',   // int after first save (columns * rows)
'grid_columns'=> [],   // list of ['value'=>…, 'unit'=>…, 'type'=>'grid_columns']
'grid_rows'   => [],   // list of ['value'=>…, 'unit'=>…, 'type'=>'grid_rows']
'grid_gap'    => [],   // [0=>row_gap, 1=>column_gap], each ['value','unit','type']
```

There is **no `config/schema`** for these keys — they are stored untyped in the section config.

## Configuration form (`buildConfigurationForm`, `:53`)

Three `details` groups, each `#tree => TRUE`, wrapped in `<div class="css-grid-layout-settings">`:

- **`grid_columns`** (`#title` "grid-template-columns", wrapper `#css-grid-columns-wrapper`): a
  repeatable list `items[$i]` of `value` (textfield, `#default_value` 1, `#step` .5) + `unit`
  (select, `#options` = `defaultUnitOptions()`, default `fr`). Row count comes from
  `$form_state->get('grid_columns')`.
  - AJAX buttons **`add_item`** ("Add column", submit `addRow`) and, when >1 row, **`remove_item`**
    ("Remove item", submit `removeLastRow`); both `#ajax` callback `layoutColumnsSettingsCallback`,
    `wrapper => css-grid-columns-wrapper`, `#limit_validation_errors => []`, `#name => grid_columns`.
- **`grid_rows`** — identical structure, wrapper `#css-grid-rows-wrapper`, `#name => grid_rows`,
  AJAX callback `layoutRowsSettingsCallback`, buttons "Add row" / "Remove item".
- **`grid_gap`** (`#css-grid-gap-wrapper`): two fixed inline `number` inputs — `row_gap` and
  `column_gap` — each with a `unit` select (`gapUnitOptions()`, default `px`), `#max => 20`,
  `#min => 0`, `#step => .5`. Defaults read `configuration['grid_gap'][0|1]['value'|'unit']`.

`addRow`/`removeLastRow` (`:437`, `:416`) push/pop an entry on `$form_state->get($type)` (where
`$type` = the button's `#name`) and call `setRebuild()`. The library `css_grid/css_grid` is attached
to the form (`$form['#attached']['library'][] = 'css_grid/css_grid'`).

`js/scripts.js` (`Drupal.behaviors.cssGridLayout`, uses `once`) reacts to unit-select changes on
`.css-grid-layout-settings select`: choosing `minmax` switches the sibling value input to text and
prefills `200px,400px`; `auto`/`min-content`/`max-content` clears + read-onlys it; anything else
resets it to a number input with value `1`.

## Validation & submit

`validateConfigurationForm` (`:286`): errors if `grid_columns.items` **or** `grid_rows.items` is
empty — "A grid requires at least one column and one row."

`submitConfigurationForm` (`:296`): calls `parent::submitConfigurationForm`, resets
`grid_cells => ''`, then per submitted value:
- For `grid_columns` / `grid_rows`: rebuilds `section_settings[$i] = {value, unit, type=$key}` from
  `items`, stores it as `configuration[$key]`, and updates `grid_cells`: if already numeric multiply
  by `count($items)`, else set to `count($items)`. Net effect: **`grid_cells = #columns × #rows`**.
- For `grid_gap`: builds `gap_settings[0]=row_gap`, `[1]=column_gap` (`{value, unit, type}`) into
  `configuration['grid_gap']`.

## Cells & dynamic regions (`setPluginDefinitionRegions`, `:363`)

Called first in `build()`. Iterates `range(1, grid_cells)` and rebuilds the plugin definition's
region map as `content_1 … content_{grid_cells}`, each labelled "Content @i", via
`$this->pluginDefinition->setRegions($regionMap)`. This is why the number of block-drop areas equals
columns × rows.

## Render (`build`, `:344`)

```php
$build['#attributes'] = [
  'class' => ['css-grid-layout'],
  'style' => [
    'grid-template-columns: ' . $this->computeGridProperties('grid_columns') . ';',
    'grid-template-rows: '    . $this->computeGridProperties('grid_rows')    . ';',
    'gap: '                   . $this->computeGridProperties('grid_gap')     . ';',
  ],
];
```

`computeGridProperties($property)` (`:381`) maps each stored `{value,unit}` entry to a CSS track:
- `auto` / `min-content` / `max-content` → just the unit keyword.
- `minmax` → `minmax(<value>)` (the value is the raw `200px,400px`-style string from the form).
- default → `<value><unit>` (e.g. `1fr`, `10px`).

Results are `implode(' ')`-joined, so e.g. columns `[1fr, 2fr]` → `grid-template-columns: 1fr 2fr;`.
The `style` value is an **array of strings** placed in a render array's `#attributes`; Drupal renders
it through its `Attribute`/`AttributeArray` API, which HTML-escapes each value — so the section-level
grid settings cannot break out of the attribute.

Template `css-grid.html.twig` renders `<section{{ attributes }}>` then loops
`for i in range(1, settings.grid_cells)` emitting `<section {{ region_attributes["content_#{i}"].addClass('layout-inner-content') }}>{{ content["content_#{i}"] }}</section>`.

## Quirks worth knowing

- The `css_grid/css_grid` library (which supplies `.css-grid-layout { display: grid }` in
  `css/style.css`) is attached only in `buildConfigurationForm()`, **not** in `build()`. On the
  rendered front end the inline `style` sets the track template and gap but not `display: grid`; that
  rule must come from the theme or from the library being loaded elsewhere. Verify grid rendering on
  the front end for the target theme.
- Config is stored without a schema, so values are not schema-typed/translatable.
