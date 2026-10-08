<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Layout Paragraphs Disable Duplicate (layout_paragraphs_disable_duplicate) — agent index

**Removes the duplicate control for selected paragraph types in the Layout Paragraphs builder.**

- **Version:** 1.0.x (1.0.1) · **Core:** ^10.1 || ^11 || ^12 · **Depends:** paragraphs, layout_paragraphs
- **Configure:** route `layout_paragraphs_disable_duplicate.settings` → `/admin/config/content/layout_paragraphs/disable-duplicate` (perm `administer site configuration`).
- **Mechanism:** `LayoutParagraphsDisableDuplicateHooks::preprocessLayoutParagraphsBuilderControls()` (`preprocess_layout_paragraphs_builder_controls`) sets `duplicate_access = FALSE` / `#access = FALSE` for types in `settings:disabled_paragraph_types`.
- **Config:** `layout_paragraphs_disable_duplicate.settings`.
- **Security:** single permission-gated admin route; no external calls, no anonymous/mutating endpoints — only hides a builder control. No security findings.
