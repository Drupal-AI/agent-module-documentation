<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `wingsuit_link` — pattern settings as link attributes

Bridges the `button` UI Pattern's variant and settings onto core link fields, so an editor picks a
button variant/settings on the link widget instead of a separate pattern form. Dependencies:
`link_attributes`, `ui_patterns_settings`.

## Mechanism (`wingsuit_link.module`)

- `hook_form_wingsuit_companion_config_form_alter` — adds the **`auto_fill_link_url`** checkbox to
  the main settings form ("Auto fill 'url' setting of your button pattern").
- `hook_link_attributes_plugin_alter` — reads the `button` pattern definition
  (`UiPatterns::getManager()->getDefinition('button')`) and injects extra link-attribute widgets:
  a **Variant** select from `getVariantsAsOptions()`, plus one widget per pattern setting of type
  `select`/`radios` (as-is) or `boolean` (as a True/False/`- Use default -` select), sourced from
  `UiPatternsSettings::getPatternDefinitionSettings()`.
- `hook_ui_pattern_settings_variant_alter` — for `pattern_id === 'button'`, overrides the pattern
  variant with the link item's stored `options.attributes.variant`.
- `hook_ui_pattern_settings_settings_alter` — for `button`, copies the link item's
  `options.attributes` into the pattern settings; when `auto_fill_link_url` is on, also sets the
  pattern's `url` setting to `$link->getUrl()->toString()`.

## `wingsuit_link.install`

- `wingsuit_link_update_8201()` prefills `auto_fill_link_url` = TRUE in `wingsuit_companion.config`.

No routes, services, or entities. Purely alter hooks against `link_attributes` and
`ui_patterns_settings`.
