<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor 5 Scroll Fix — agent start

Front-end usability fix. `hook_form_alter` attaches library `ckeditor5_scroll_fix/scroll-fix` to forms ending in
`_node_form`/`_edit_form`/`_block_form` that contain a CKEditor 5 `text_format` element (detected by
`ckeditor5_scroll_fix_findTextFormatRecursive`).

- JS (`js/ckeditor-scroll-fix.js`) blurs the editor and dispatches a safe click when a scroll-lock is detected;
  includes 1s mobile input-intent suppression. Deps: `core/drupal`, `core/once`.
- No routes/permissions/config. Key files: `ckeditor5_scroll_fix.module`, `js/ckeditor-scroll-fix.js`.
- See ../usage.md.
