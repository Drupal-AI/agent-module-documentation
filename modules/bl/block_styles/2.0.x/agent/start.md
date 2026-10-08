<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Block Styles — agent index

Adds a **"Block Styles Template"** fieldset to every block's config form so you can attach a
template suggestion (a `block--*.html.twig`) and CSS classes to a placed block, choosing from styles
registered via the **Styles API** (`*.themes.yml`, `type: block`). No central settings page
(`configure: null`); config is per block. Depends on `styles_api` + core `block`.

- **Apply a style/classes to a block, and the `block_styles.blocks.<id>` config entity (theme/classes/text)** →
  [configure/block-styles.md](configure/block-styles.md)
- **How rendering works: the three hooks, Styles API integration, theme-provider restriction** →
  [api/mechanism.md](api/mechanism.md)
- **Register your own block style with a `*.themes.yml` file + Twig template** →
  [theming/styles.md](theming/styles.md)

Submodule: [block_styles_bootstrap](../../modules/block_styles_bootstrap/2.0.x/agent/start.md) —
adds Bootstrap card/collapse/dropdown/modal/popover styles.

Key facts:
- Config entity id = the **block's id**; config name `block_styles.blocks.<block_id>`; keys
  `theme` (style/suggestion id), `classes`, `text`.
- Bundled style: **Clean Wrapper** = `block__clean`. Style ids look like `block__<name>`.
- `hook_theme_suggestions_block_alter()` sets the template suggestion; `hook_preprocess_block()`
  adds the classes and `configuration.button_text`.
