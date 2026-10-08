<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Styles, style groups & grid layouts (YAML discovery + config)

The `style` and `grid_layout` behaviors do not hard-code their options. They discover them from YAML
files contributed by **any enabled module or theme**, via `Drupal\Core\Discovery\YamlDiscovery`
keyed by these filename suffixes (see `paragraphs_collection.api.php`):

| Suffix | Discovered by | Defines |
|---|---|---|
| `<provider>.paragraphs.style.yml` | `StyleDiscovery` (`getStyles()`) | individual styles |
| `<provider>.paragraphs.style_group.yml` | `StyleDiscovery` (`getStyleGroups()`) | style groups (the `style` behavior is configured per group) |
| `<provider>.paragraphs.grid_layouts.yml` | `GridLayoutDiscovery` (`getGridLayouts()`) | grid layouts |

## Define a style

```yaml
# my_theme.paragraphs.style.yml
my_highlight:
  title: 'Highlight'          # required; a missing title throws InvalidStyleException
  description: 'Yellow highlight box.'
  groups:
    - general_group           # ids from a *.paragraphs.style_group.yml
  libraries:
    - 'my_theme/highlight'    # CSS attached when the style is applied
  classes:                    # optional: merged onto the paragraph #attributes['class']
    - 'is-highlight'
  attributes:                 # optional: merged onto the paragraph #attributes
    role: 'note'
  template: 'highlight'       # optional: adds a paragraph__<bundle>__highlight suggestion
  permission: true            # optional: gate behind the 'use my_highlight style' permission
```
Applying a style adds the class `paragraphs-behavior-style--my_highlight`, then merges `libraries`,
`classes` and `attributes`. `classes`/`attributes` come straight from this YAML (author/developer
trust) and are escaped by the Attribute renderer on output.

## Define a style group

```yaml
# my_theme.paragraphs.style_group.yml
general_group:
  label: 'General Group'      # required; missing label throws InvalidStyleException
  widget_label: 'Style'       # optional; falls back to '<label> style'
```

## Define a grid layout

```yaml
# my_module.paragraphs.grid_layouts.yml
my_two_col:
  title: 'Two columns 1 - 1'  # required; missing title throws InvalidGridLayoutException
  description: 'Two equal columns.'
  wrapper_classes:
    - my-grid-row
  columns:
    - classes: ['my-col-1-2']
    - classes: ['my-col-1-2']
  libraries:
    - 'my_module/grid_layout'
```
`columns` count = number of output columns; `ParagraphsGridLayoutPlugin::preprocess()` assigns the
column `classes` to referenced items round-robin and `wrapper_classes` to the field wrapper.

The bundled examples live in the demo submodule:
`paragraphs_collection_demo.paragraphs.style.yml` (`paragraphs-green`, `paragraphs-blue`,
`paragraphs-slideshow-light`, `paragraphs-slideshow-dark`),
`…style_group.yml` (`general_group`, `slideshow_group`), and `…grid_layouts.yml`
(`paragraphs_collection_demo_1_1_column`, `…_1_2_column`, `…_equal_columns`, etc.).

## Enabled-styles config form + report pages

- `/admin/reports/paragraphs_collection/styles` (route `paragraphs_collection.styles`,
  permission `administer paragraphs types`) renders `StylesOverviewForm`
  (id `paragraphs_collection_styles_overview_form`, a `ConfigFormBase`). Checking a style writes its
  name into `paragraphs_collection.settings:enabled_styles`. **Semantics:** an *empty* `enabled_styles`
  means **all** discovered styles are available; a non-empty list restricts to exactly those
  (`StyleDiscovery::getStyleOptions()`/`getStyle()`).
- `/admin/reports/paragraphs_collection/layouts` (route `paragraphs_collection.layouts`, same
  permission) is a read-only table of every discovered grid layout and which paragraph types allow
  it. Menu link under Reports; local tasks "Layouts" / "Styles".

## Config schema, permissions & cache

- Config object `paragraphs_collection.settings` — schema in
  `config/schema/paragraphs_collection.schema.yml`; installed default in
  `config/install/paragraphs_collection.settings.yml` (`enabled_styles: {}`).
- Permissions: static `administer lockable paragraph`; **dynamic** `use <style-name> style` generated
  by `Permissions::permissions()` (referenced from `paragraphs_collection.permissions.yml` via
  `permission_callbacks`) for every discovered style whose YAML sets `permission: true`.
- Caching: discovery results are cached in the `discovery` cache
  (`paragraphs_collection_style`, `paragraphs_collection_style_group`,
  `paragraphs_collection_grid_layouts`). `StyleDiscovery::reset()` clears the style caches and the
  `.module` calls it on module/theme install/uninstall. Saving `paragraphs_collection.settings`
  invalidates the `rendered` cache tag via the
  `paragraphs_collection.style_config_cache_tag_invalidator` event subscriber
  (`ConfigEvents::SAVE`). Clear caches (`drush cr`) after adding new YAML files.
