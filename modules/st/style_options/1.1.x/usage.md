<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Style Options is an API module that lets site builders define reusable "style" controls (CSS classes, background colors, background images, arbitrary properties) in YAML and expose them on Layout Builder layouts/regions and Paragraph types, so editors can style components without code.

---

The module defines a `style_option` plugin type (manager `plugin.manager.style_options`, base dir `Plugin/StyleOption`, annotation `@StyleOption`) and ships four plugins: `css_class`, `background_color` (a Spectrum color picker, applied via a CSS class or inline style), `background_image`, and a generic `property`. You declare which options exist, and where they appear, in a discovery file named `[module|theme].style_options.yml` placed at the root of a module or theme (read by `StyleOptionConfigurationDiscovery`). That file has two sections: `options:` (each keyed entry picks a `plugin:` and configures its `label`, `multiple`, choice list, color palette, etc.) and `contexts:` (which options are offered for each `layout` plugin and each `paragraphs` type, with `_defaults`, per-plugin overrides, and `_disable` lists; layout options can be flagged for the layout itself and/or its `regions`). Two integration plugins wire the options into Drupal: `StyleOptionLayoutPlugin` (a `LayoutDefault` subclass — your layouts must extend it to get the controls) and `StyleOptionBehavior` (a Paragraphs behavior plugin, id `style_options`, that you enable per paragraph type). Selected values are stored in the layout/paragraph component config and rendered as classes, inline styles, or themed markup (`style_options_background_color`, `style_options_background_image` theme hooks). The module has no admin settings page of its own; its only route is a one-shot migration form (`/admin/config/style-options/migrate`) for importing configuration from the older Option Plugin module. Extend it with `hook_style_options_alter()` (plugin-info alter) or by adding your own `@StyleOption` plugin.

---

- Give editors a dropdown of approved CSS classes (e.g. "Style 1 / Style 2") on a Layout Builder section.
- Add a background-color picker (Spectrum) to a paragraph type so authors can tint a component.
- Offer a background-image control on hero/banner layouts and paragraphs.
- Apply a chosen CSS class to a whole layout and, optionally, to each of its regions.
- Restrict a color option to a specific one-column layout only, via the `contexts.layout` overrides.
- Define a curated color palette (brand colors) for the background-color option.
- Let multiple CSS classes be selected at once by setting `multiple: true` on a `css_class` option.
- Standardize spacing/typography choices across paragraph types using the generic `property` plugin.
- Disable an inherited default option for one layout or paragraph type with `_disable`.
- Expose styling controls without granting editors raw HTML/CSS access.
- Keep style definitions in version control as `[theme].style_options.yml` in your theme.
- Reuse the same option set across both Layout Builder and Paragraphs from one YAML file.
- Add per-region background images in a multi-column Layout Builder section.
- Migrate existing configuration from the legacy Option Plugin module via the migrate form.
- Provide "inline" vs "css" application methods for background color depending on the design.
- Build a design-system-style set of component modifiers editors can pick from.
- Add a custom `@StyleOption` plugin for a bespoke control (e.g. a spacing scale or icon picker).
- Alter available options programmatically with `hook_style_options_alter()`.
- Attach chosen classes to rendered components so a theme's CSS can style them predictably.
- Let content teams theme paragraphs consistently instead of one-off inline styles.
- Combine with image_radios to render class choices as clickable image thumbnails.
- Offer alpha-enabled background colors (`showAlpha`) for overlays and tints.
- Apply themed background markup via the module's `style_options_background_*` templates.
- Roll out a controlled set of visual variations for a page-builder workflow.
