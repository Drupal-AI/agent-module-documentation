<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Layout Builder Blocks styles

One admin form controls (a) which Bootstrap Styles plugins editors may use and (b) an optional
allow-list of blocks that may be styled.

- **Route:** `layout_builder_blocks.styles` → path `/admin/config/layout-builder-blocks/styles`
  (menu link under *Configuration → Content authoring*, `system.admin_config_content`).
- **Permission:** `configure bootstrap layout builder` (provided by `bootstrap_styles`, not this module).
- **Form:** `Drupal\layout_builder_blocks\Form\StylesForm` (extends Bootstrap Styles'
  `StylesFilterConfigForm`, form id `bootstrap_styles_filter`).
- **Config object:** `layout_builder_blocks.styles` (this module ships **no** config schema; the
  object is created on first save).

## Config keys

| Key | Type | Meaning |
|---|---|---|
| `plugins.<group>.<style>.enabled` | bool | Whether a Bootstrap Styles plugin is offered in the Style tab. Groups/styles: `background.background_color`, `background.background_media`, `typography.text_color`, `typography.text_alignment`, `spacing.padding`, `spacing.margin`, `border.border`, `shadow.box_shadow`, `animation.scroll_effects`. |
| `block_restrictions` | sequence (list of strings) | Block plugin IDs the Style tab is limited to. **Empty/absent = all blocks get the Style tab.** |

`block_restrictions` entries are raw block plugin IDs, e.g. `system_powered_by_block`,
`system_branding_block`, or for custom block *types* `inline_block:<bundle>` (a single
`inline_block:<bundle>` entry covers both inline blocks of that bundle **and** reusable blocks
of that bundle — the form lists them together under "Custom block types"). Reusable blocks are
matched by resolving the `block_content:<uuid>` plugin to its bundle.

## Read / set with drush

```bash
# View current settings
drush config:get layout_builder_blocks.styles

# Restrict the Style tab to just the "Powered by" block
drush config:set layout_builder_blocks.styles block_restrictions.0 system_powered_by_block -y

# Enable the background-color style plugin
drush config:set layout_builder_blocks.styles plugins.background.background_color.enabled 1 -y

# Remove all restrictions (Style tab on every block) — set to an empty list
drush php:eval '\Drupal::configFactory()->getEditable("layout_builder_blocks.styles")->set("block_restrictions", [])->save();'
```

Where the *content* of the style options (the actual color classes, spacing values, etc.) is
defined is the **Bootstrap Styles** config (`bootstrap_styles.settings`) and its own admin form —
this module only decides which of those plugins appear and on which blocks.
