<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor 5 Scroll Fix

Fixes the page-scroll lock that happens when a CKEditor 5 image/widget grabs focus.


## What & when

- Use it when editors report that the page will not scroll after clicking an image/widget in CKEditor 5.
- It detects the focus-lock situation and blurs the editor / dispatches a safe click so scrolling resumes.
- Includes mobile "input intent" detection so it does not fight the on-screen keyboard.

---

## Install & configure

- `composer require drupal/ckeditor5_scroll_fix` then `drush en ckeditor5_scroll_fix -y` (needs core `ckeditor5`).
- Zero configuration — no settings form, permissions, or routes.
- Via `hook_form_alter` it attaches `ckeditor5_scroll_fix/scroll-fix` to forms whose id ends in `_node_form`, `_edit_form`, or `_block_form`.
- It only attaches when the form actually contains a `text_format` element using a CKEditor 5 editor (found by recursive form scan).

---

## Usage & behaviour

- Restores normal page scrolling after interacting with CKEditor 5 image widgets.
- Improves the editing experience on long node edit forms.
- Handles mobile: a 1s "input intent" window after tapping the editor prevents accidental blur when the keyboard opens.
- Throttles scroll handling (150ms guard + 100ms timer) to stay cheap.
- Only acts when the active element is inside `.ck-editor__editable`.
- Leaves the editor alone when the mouse is over the editor bounding box.
- Dispatches synthetic mousedown/mouseup/click to a safe container (`main`, `.layout-container`, `article`, `.region-content`, or body).
- No effect on forms without a CKEditor 5 text_format field.
- Depends only on `core/drupal` and `core/once`.
- Applies to node forms, generic entity edit forms, and block forms.
- Purely a front-end usability fix; no data is changed or stored.
- Safe to leave enabled site-wide; it is a no-op where not needed.
- No JavaScript API for other modules.
- The recursive scan returns the first CKEditor 5 format id it finds to decide whether to attach.
- Works on Drupal 10 (`^10`).
