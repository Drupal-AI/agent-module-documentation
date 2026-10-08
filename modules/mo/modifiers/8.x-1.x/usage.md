<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Modifiers is a framework that defines a "modifier" plugin type: each plugin turns stored field values (colours, spacing, images, animation settings) into CSS, JS library attachments and DOM attributes, and attaches them to a specific entity, region or Layout Builder section by a generated CSS selector.

---

The core mechanism is `Drupal\modifiers\Modifiers`. On `hook_entity_view_alter` it looks for a `field_modifiers` reference field on the viewed entity, walks the referenced paragraphs/entities and flattens their fields into a simple config array (stripping the `field_mod_`/`field_` prefix from each field name, resolving media references to file URLs via a `media`/`taxonomy_term`-to-field mapping table, and converting `color_field_type` values to `rgba()` through `getColorValue()`, which validates the hex with `preg_match('/[0-9A-F]{6}/i')`). It then adds marker classes (`modifiers`, `modifiers-id-<type>-<id>`, `modifiers-type-*`, `modifiers-bundle-*`, `modifiers-display-*`) to the build, and for each modifier key with a matching plugin definition calls the plugin's static `::modification($selector, $config)` with a very specific selector (`html body .modifiers.modifiers-id-...`). Each plugin returns a `Modification` object carrying five arrays: **css** (`[media][selector] => [properties]`), **libraries**, **settings** (for JS), **attributes** (for JS), and **links** (head `<link>` elements). `Modifiers::apply()` concatenates the CSS via `renderCss()` (`$selector . '{' . implode(';', $properties) . '}'`, wrapped in `@media` when the media key is not `all`) and attaches it as one `#attached['html_head']` `<style media="all" data-modifiers="...">` element whose `#value` is `Markup::create($style)` — so modifier CSS is emitted inline in the page head, not written to a file. Libraries go to `#attached['library']`, settings/attributes to `drupalSettings.modifiers`, where `js/modifiers.init.js` (the always-attached `modifiers/init` library) dispatches each setting to `window[namespace][callback](...)` and toggles per-media-query attributes/classes on matched selectors. `modifiers_preprocess_layout` does the same for Layout Builder: custom block types whose bundle ends in `_modifier` are read from each region and applied to the section (when `field_lb_modifiers_section` is set) or to the region. The plugin manager (`plugin.manager.modifier`) discovers plugins from `Plugin/modifiers` (attribute `#[Modifier]` or annotation `@Modifier`) in modules **and themes**, plus a YAML (`*.modifiers.yml`) discovery decorator. This base module ships **no** concrete modifier plugins, no config, no permissions and no schema — it is pure plumbing; real plugins come from Modifiers Pack, and Look layers per-page collections on top. Three alter hooks exist: `hook_modifiers_info_alter`, `hook_modifiers_mappings_alter`, `hook_modifiers_entity_view_config_alter`.

---

- Provide a developer-defined, discoverable set of presentation options instead of a free-text CSS class field.
- Apply a background colour or image to a paragraph section.
- Add responsive spacing (margin/padding) above or below a component.
- Attach a scroll/entrance animation to a card via a JS library modifier.
- Set an `rgba()` background from a colour field plus opacity.
- Apply a modifier to a whole theme region (header, footer) rather than one entity.
- Style a Layout Builder section or region using a `*_modifier` custom block type.
- Give editors colour-scheme choices sourced from `modifiers_color` taxonomy terms.
- Attach a background video or parallax image to a hero (via Modifiers Pack plugins).
- Emit media-query-scoped CSS so a modifier only applies at certain breakpoints.
- Add corner-radius or box-shadow options to reusable components.
- Reduce paragraph-type proliferation by making one type configurable with modifiers.
- Build a design-system vocabulary of named, finite presentation tokens.
- Toggle DOM classes/attributes per breakpoint through the JS init behaviour.
- Reference an image media entity and have its file URL injected into generated CSS.
- Let a theme (not just a module) ship its own modifier plugins.
- Alter the entity-type/bundle-to-field mapping so custom media/colour fields feed modifiers.
- Apply the same modifier to view modes (full, teaser) or WYSIWYG classes via selectors.
- Attach `<link>` head elements (e.g. fonts) as part of a modifier.
- Keep presentation values in content (they version, export and migrate with the entity).
- Alter or override a third-party modifier's definition with `hook_modifiers_info_alter`.
- Serve as the foundation for the Look module's per-page modifier collections.
