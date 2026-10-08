<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# FAQ Block — agent orientation

D10 module providing one block plugin: `src/Plugin/Block/FaqBlock.php`, plus a custom form element `src/Element/FaqFileds.php`.

- Block config stores `faq_items` (question + rich-text answer), `section_title`, `section_description`, `toggle_icon_color`.
- AJAX add/remove item buttons manage the item count via form state.
- `custom_editor_record_file_usage()` promotes embedded temp files to permanent and records file usage.
- Rendered via `faq_block` theme hook. Content is admin/block-config only (no public routes, no permissions). Low security surface; answers are admin-authored rich text.
