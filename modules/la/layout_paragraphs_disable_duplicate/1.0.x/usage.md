<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Layout Paragraphs Disable Duplicate lets you switch off the "duplicate" button that Layout Paragraphs shows on components, on a per-paragraph-type basis.

---

Layout Paragraphs renders a set of controls (edit, delete, duplicate, ...) on each component in its builder UI. For some paragraph types — singletons, tightly controlled layout wrappers, or components that must not be copied — duplication is undesirable. This module adds a settings form at `/admin/config/content/layout_paragraphs/disable-duplicate` (permission `administer site configuration`) where you select which paragraph types should have the duplicate control removed. A hook implementation, `LayoutParagraphsDisableDuplicateHooks::preprocessLayoutParagraphsBuilderControls()` (`#[Hook('preprocess_layout_paragraphs_builder_controls')]`), reads `layout_paragraphs_disable_duplicate.settings:disabled_paragraph_types` and, for listed types, sets `duplicate_access = FALSE` and `#access = FALSE` on the duplicate link.

The only route is permission-gated and the module has no external calls, no anonymous endpoints, and no data-mutating APIs — it merely hides a builder control via render-array access. It depends on `paragraphs` and `layout_paragraphs`.

---
- Remove the duplicate button for a specific paragraph type.
- Prevent editors from cloning a singleton layout component.
- Disable duplication on wrapper/section paragraph types.
- Configure disabled types at Config › Content › Layout Paragraphs.
- Keep the duplicate control for all other paragraph types.
- Enforce content-modelling rules in the Layout Paragraphs UI.
- Restrict who can change the disable-duplicate settings.
- Reduce accidental duplication of complex components.
- Combine multiple paragraph types in one disable list.
- Apply the restriction across all Layout Paragraphs fields.
- Hide duplicate on hero/banner components.
- Prevent duplication of components with unique IDs or anchors.
- Simplify the editor toolbar for constrained content types.
- Roll out consistent editing rules on Drupal 10.1+/11/12.
- Toggle the behaviour off by clearing the settings list.
- Pair with other Layout Paragraphs restrictions for governance.
