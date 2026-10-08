<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How it works (mechanism)

The module is `block_styles.module` (a few hooks) + a `block_styles` config entity + one style
definition (`block_styles.themes.yml`). Styling data flows: **block form → config entity → block
render**.

## The hooks

1. `block_styles_form_block_form_alter()` — adds the **Block Styles Template** fieldset (a `select` of
   Styles API `type: block` styles, a conditional `text` field, and a `classes` textfield) and a
   submit handler `_block_styles_form_submit()`. The `text` field is only enabled for a style whose
   plugin definition has `extras.label` truthy (AJAX-driven). Submit creates/updates a `block_styles`
   config entity keyed by the block id with `theme`/`classes`/`text`.

2. `block_styles_theme_suggestions_block_alter()` — for a block with a saved style, looks up
   `_block_styles_get_style($block_id)` and, if it has a `theme`, appends it to `$suggestions`. This is
   what makes Drupal render `block--<suggestion>.html.twig` instead of `block.html.twig`.

3. `block_styles_preprocess_block()` — adds the saved `classes` to `$variables['attributes']['class']`
   and sets `$variables['configuration']['button_text']` to the style's `text` (falling back to the
   block label).

## Styles API integration

`_block_styles_get_style()` loads the `block_styles` entity and reads the matching style definition
from the Styles API plugin manager (`\Drupal::service('plugin.manager.styles_api')`, wrapped by
`\Drupal\styles_api\Style::stylePluginManager()`). Styles come from `*.themes.yml` files discovered by
`styles_api` (a `YamlDiscoveryDecorator` on the `themes` key). Only definitions with `type: block` are
offered in the block form.

**Theme-provider restriction:** if the chosen style's `provider_type` is `theme` and that theme is not
the active theme, `_block_styles_get_style()` returns FALSE — the style is skipped. Module-provided
styles always apply.

## Config entity

`@ConfigEntityType(id = "block_styles", config_prefix = "blocks", …)` with `config_export`
`id`, `theme`, `text`, `classes`. So saved config is named **`block_styles.blocks.<block_id>`**
(note: the shipped config schema key is `block_styles.block_styles.*`, which does not match the
`blocks` prefix — a harmless schema-coverage quirk). `getStyle()` returns
`['theme' => …, 'classes' => …, 'text' => …]`.

## Bundled style

`block_styles.themes.yml` registers **`block__clean`** ("Clean Wrapper", `type: block`,
template dir `templates/clean`, `base hook: block`, `render element: elements`). See
[../theming/styles.md](../theming/styles.md) to register your own.
