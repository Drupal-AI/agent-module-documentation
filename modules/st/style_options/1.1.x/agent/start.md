<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Style Options — agent index

An API to declare reusable style controls (CSS class, background color/image, arbitrary property)
in YAML and expose them on Layout Builder layouts/regions and Paragraph types.

- **Declare options & contexts in `[ext].style_options.yml`; wire up Layout Builder & Paragraphs** →
  [configure/style-options-yml.md](configure/style-options-yml.md)
- **The `style_option` plugin type: shipped plugins and how to add one** →
  [plugins/style-option.md](plugins/style-option.md)
- **Alter available options** → [hooks/alter.md](hooks/alter.md)

Key facts:
- No admin settings page (`configure: null`). Its only route is the one-shot Option Plugin
  migration form at `/admin/config/style-options/migrate` (`style_options.migrate_data`).
- Plugin type `style_option`: manager `plugin.manager.style_options`, dir `Plugin/StyleOption`,
  annotation `@StyleOption`. Shipped ids: `css_class`, `background_color`, `background_image`,
  `property`.
- Integration: layouts must extend `StyleOptionLayoutPlugin` (a `LayoutDefault`); Paragraphs use
  the `style_options` **Paragraphs behavior** plugin (`StyleOptionBehavior`), enabled per paragraph
  type → stored at `paragraphs.paragraphs_type.<type>.behavior_plugins.style_options.enabled: true`.
- No config schema, no permissions of its own, no Drush. Paragraphs integration needs the
  `paragraphs` module (a soft dependency, not declared in info.yml).
- Discovery service `style_options.discovery` (`StyleOptionConfigurationDiscovery`) reads the
  `*.style_options.yml` files from every module and theme.
