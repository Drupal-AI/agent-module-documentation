# The `[provider].layout_options.yml` file

Layout Options is configured by YAML files (not an admin form). Any module or theme places a
`{provider}.layout_options.yml` in its root; the `LayoutOptions` layout plugin discovers and
merges them across providers. It has two top-level sections.

## 1. `layout_option_definitions` — the available options

Each key is an option id; its value declares the control:

```yaml
layout_option_definitions:
  layout_id:
    title: 'Id attribute'
    description: 'The CSS identifier for this layout item.'
    default: ''
    plugin: layout_options_id            # which LayoutOption plugin renders it
    layout: true                         # applies to the whole layout
    regions: true                        # applies to each region
    weight: -100                         # optional: form ordering
    allowed_regions: [left, top]         # optional: restrict to regions
  layout_bg_color:
    title: 'Background color'
    default: ''
    plugin: layout_options_class_select  # select of CSS classes
    multi: false
    options:
      bg-info: 'Info'
      bg-primary: 'Primary'
    layout: true
    regions: true
  layout_design_classes:
    title: 'Layout classes'
    plugin: layout_options_class_checkboxes
    inline: true
    options:
      layout--no-spacing: 'No Padding/Margin'
      layout--full-width-img: 'Full Width Image'
    layout: true
    regions: true
  layout_custom_classes:
    title: 'Custom classes'
    plugin: layout_options_class_string  # free-text classes
    layout: true
    regions: true
```

Common keys: `title`, `description`, `default`, `plugin` (a `LayoutOption` id), `layout`
(bool), `regions` (bool), `options` (for select/radios/checkboxes), `multi`, `inline`,
`weight`, `allowed_regions`.

## 2. `layout_options` — the rules (which options show where)

```yaml
layout_options:
  global:                      # shown on ALL layouts unless overridden
    layout_id: {}
    layout_bg_color: {}
  my_layout_2col_50_50:        # only this layout id
    layout_bg_color:
      regions: false           # override: only on the layout, not its regions
      layout: true
    layout_design_classes:
      title: 'Header custom classes'   # override the title here
  field_header:                # field-specific (Entity Reference Layout)
    layout_id:
      regions: false
      layout: false
    layout_custom_classes: {}
```

- `global` options appear on every layout that uses the `LayoutOptions` plugin.
- A section keyed by a **layout id** adds/overrides options for that layout only.
- A section keyed by a **field name** applies for layouts managed per-field (Entity Reference
  Layout).
- Empty `{}` = use the definition as-is; a map overrides definition keys (title, layout,
  regions, …).

## Applying it

The layout must use the `LayoutOptions` plugin class. For a layout you define yourself, set
`class: Drupal\layout_options\Plugin\Layout\LayoutOptions` in your `*.layouts.yml`. To retrofit
existing core/contrib layouts, use the **layout_options_ui** submodule (see its docs), which
swaps their class via `hook_layout_alter`. Selected values are stored with the layout section
config and applied as classes/attributes at build time (with CSS-identifier validation).
