<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# VLSuite Landing (vlsuite_landing) — agent index

Submodule of **vlsuite**. A **landing page content type** with Layout Builder enabled and the
suite's components permitted. Version **2.3.3**. Core `^10.3 || ^11`.

Dependency list is effectively the recommended component set (`_block_cta`, `_image`, `_icon`,
`_local_video`, `_remote_video`, `_text`, `_headings_menu`, `_attachments`) plus two Layout Builder
modules that matter:

- **`layout_builder_restrictions`** — stops the block list being every block on the site.
- **`layout_builder_at`** (Asymmetric Translation) — **the one to understand**: without it,
  translating a Layout Builder page is awkward because core ties layout to the original language.
  On a multilingual site this dependency is doing real work.

Nested: `vlsuite_landing_content_editor` (editor role configuration).

**Fastest route into the suite** — enable it and adjust, rather than assembling from parts.