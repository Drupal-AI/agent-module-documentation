<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Inline Block Title Automatic - ST (inline_block_title_automatic_st) — agent index

**Glue module: on the Layout Builder Symmetric Translation inline-block translate form, hides the block title field and skips duplicate-title validation.**

- **Version:** 2.0.x
- **Core:** >=8
- **Dependencies:** `inline_block_title_automatic`, `layout_builder_st`.
- **Mechanism:** `hook_form_block_content_form_alter()` targets `BlockContentInlineBlockTranslateForm`; sets `info` to a `value` element and trims it from `#limit_validation_errors`.
- **Config:** none — zero-configuration, no routes or permissions.

**Security:** a single form_alter on an admin translate form; no routes, permissions, input handling, or storage — no findings.