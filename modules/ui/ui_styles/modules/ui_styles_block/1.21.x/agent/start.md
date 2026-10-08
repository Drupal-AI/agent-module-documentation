<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# UI Styles Block — agent index

Adds UI Styles selectors (**block**, **title**, **content**) to the block-layout block
config form. Choices are stored on the `block.block.<id>` config entity under
`third_party_settings.ui_styles`, then merged onto the block's attributes at render time.
No routes, permissions, or settings form.

- **Where styles are stored on a block, the three parts, and how to set them** →
  [configure/block-styles.md](configure/block-styles.md)

Key fact: `block.block.<id>` →
`third_party_settings.ui_styles.{block,title,content}` = `{selected: {style_id: class}, extra: "classes"}`
(schema type `ui_styles.selected_mapping`). Rendered into `attributes`, `title_attributes`,
`content_attributes` by `PreprocessBlock`. Requires the `ui_styles` + `block` modules.
