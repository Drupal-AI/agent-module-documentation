Layout Options provides a configurable Layout plugin plus a set of "option" plugins so you can add styling controls (CSS classes, an id, custom classes) to Drupal layouts declaratively via YAML files — in most cases with no PHP.

---

The module ships a `LayoutOptions` layout plugin (`Drupal\layout_options\Plugin\Layout\LayoutOptions`, extending core `LayoutDefault`) that reads `[provider].layout_options.yml` files from any module or theme. Such a file has two sections: `layout_option_definitions` (each option's title, description, default, the `LayoutOption` plugin that renders it, and whether it applies to the whole `layout` and/or its `regions`) and `layout_options` (rules deciding which options show on which layouts — `global`, per-layout-id, or per-field — and allowing per-context overrides like changing a title or disabling regions). Options are `LayoutOption` plugins (annotation `@LayoutOption`, manager `plugin.manager.layout_options`); the built-ins cover an id attribute (`layout_options_id`) and CSS classes as a select (`layout_options_class_select`), radios (`layout_options_class_radios`), checkboxes (`layout_options_class_checkboxes`), or a free-text string (`layout_options_class_string`). Selected values are validated (CSS identifier checks) and applied as attributes/classes to the layout or region wrapper at build time. For a layout to expose these options it must use the `LayoutOptions` plugin class; the bundled **`layout_options_ui`** submodule provides an admin form that swaps the class of existing core/contrib layouts to `LayoutOptions` so you don't have to redefine them. The base module itself has no settings form or configuration (only a config schema for stored option values); it is meant to be driven by YAML and used inside Layout Builder / Display Suite.

---

- Add a "Background color" select of CSS classes to your layouts via a YAML file.
- Add an id attribute option to a layout section for in-page anchors.
- Offer a set of checkbox "design classes" (spacing, width) editors can toggle per section.
- Provide a free-text custom-classes field on a layout for advanced users.
- Add radios of style variants (e.g. themes) to a layout region.
- Apply options to a whole layout, to its regions, or to both.
- Limit an option to specific regions with `allowed_regions`.
- Show an option globally on every layout, or only on a specific layout id.
- Override an option's title or region availability for one particular layout.
- Configure layout styling entirely in a theme's `[theme].layout_options.yml` with no PHP.
- Style Layout Builder sections with reusable, centrally-defined class options.
- Give site builders a controlled palette of CSS classes instead of arbitrary input.
- Enforce valid CSS identifiers on entered classes/ids automatically.
- Add utility/spacing classes to sections to match a design system.
- Implement a custom `LayoutOption` plugin for a bespoke control (e.g. a media picker).
- Reuse one option definition across many layouts through the `global` rules section.
- Make an existing core layout (e.g. one/two column) accept options via the layout_options_ui submodule.
- Add per-field option sets when using Entity Reference Layout.
- Keep layout styling decisions in version-controlled YAML rather than the database.
- Provide different option sets per theme, since definitions merge across providers.
- Set default classes/ids on layouts through option `default` values.
- Build a component-style layout system on top of core Layout Builder.
