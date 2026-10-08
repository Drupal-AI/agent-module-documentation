<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# VLSuite Block (vlsuite_block) — agent index

Submodule of **vlsuite**. The **block-type layer** — shared configuration for VLSuite
`block_content` bundles, with **10 component submodules** beneath it.
Version **2.3.3**. Core `^10.3 || ^11`.

Depends on `block_content`, `views`, **`layout_builder_restrictions`**, `vlsuite_utility_classes`,
`vlsuite_media`, `vlsuite_slider`, `vlsuite_animations`.

**`layout_builder_restrictions` is the significant dependency** — it controls which blocks an
editor may place in which section. Without it a component library degrades into a list of
everything the site has ever defined.

Nested: `vlsuite_block_cta`, `_text`, `_image`, `_icon`, `_local_video`, `_remote_video`,
`_webform`, `_attachments`, `_headings_menu`, `_paragraph`.

Components are `block_content` entities — revisioned, translatable, and reusable through the block
library, so "inline on one page" and "shared across twenty" are the same type with a different
reuse setting.