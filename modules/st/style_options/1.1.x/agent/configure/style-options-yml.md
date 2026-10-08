<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Declaring style options and wiring them up

Style Options is configured with a **discovery YAML file**, not the config system. Create a file
named `[module_machine_name].style_options.yml` or `[theme_machine_name].style_options.yml` at the
**root** of a module or theme. `StyleOptionConfigurationDiscovery` (service `style_options.discovery`)
merges these across all extensions.

## File structure

Two top-level sections: `options` (what controls exist) and `contexts` (where they appear).

```yaml
options:
  example_class:                 # arbitrary key
    plugin: css_class            # css_class | background_color | background_image | property
    label: 'My custom class'
    multiple: true               # allow multiple selections (default false)
    options:                     # choice list for css_class
      - { label: None }
      - { label: 'Style 1', class: style_1 }
      - { label: 'Style 2', class: style_2 }

  bg_color:
    plugin: background_color
    label: 'Background Color'
    method: css                  # 'css' (adds a class) or 'inline' (inline style)
    settings:                    # passed to the Spectrum color picker (bgrins.github.io/spectrum)
      allowEmpty: true
      showAlpha: true
      showPalette: true
      palette:
        - ['#CC0000', '#E04800', '#F29300']

  bg_image:
    plugin: background_image
    label: 'Background Image'
    method: css

contexts:
  layout:                        # Layout Builder plugins
    _defaults:
      options:
        example_class:
          layout: true           # show as a layout-level option
          regions: true          # also show on each region
    layout_onecolumn:            # override for a specific layout plugin id
      _disable: [example_class]  # turn off an inherited default
      options:
        bg_color: { layout: true }

  paragraphs:                    # Paragraph types (by paragraph type id)
    _defaults:
      options:
        example_class: true
    text_paragraph:
      _disable: [example_class]
      options:
        bg_color: true
```

- `_defaults` sets options for **all** layouts / all paragraph types; a specific plugin/type key
  overrides them; `_disable` removes inherited options.
- For `layout` contexts, each option can be flagged `layout: true` (on the section itself) and/or
  `regions: true` (on every region).
- See the shipped `example.style_options.yml` in the module root for the full reference.

## Wiring into Layout Builder

Your layout plugins must extend `Drupal\style_options\Plugin\Layout\StyleOptionLayoutPlugin`
(a `LayoutDefault` subclass) so the option forms are added to the layout's configuration form.
Reference it from your `*.layouts.yml` via `class:` (or subclass it).

## Wiring into Paragraphs

Enable the **Style Options** paragraph behavior on each paragraph type that should get the controls:

- UI: *Structure → Paragraph types → [type] → Edit → Behaviors* → tick **Style Options** → Save.
- Config result: `paragraphs.paragraphs_type.<type>` →
  `behavior_plugins.style_options.enabled: true`.
- Scriptable:

```php
$pt = \Drupal\paragraphs\Entity\ParagraphsType::load('my_type');
$pt->getBehaviorPlugin('style_options')->setConfiguration(['enabled' => TRUE]);
$pt->save();
// read back: drush cget paragraphs.paragraphs_type.my_type behavior_plugins.style_options
```

## Migrating from Option Plugin

If coming from the `option_plugin` module: rename the old YAML files to `[ext].style_options.yml`,
then visit `/admin/config/style-options/migrate` (route `style_options.migrate_data`,
permission `administer site configuration`) and press the button. It copies each paragraph's
`option_plugin` behavior settings to `style_options`.
