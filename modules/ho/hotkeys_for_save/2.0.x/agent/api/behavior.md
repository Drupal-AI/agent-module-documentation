<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The JS behavior (`js/hotkeys_for_save.js`)

`Drupal.behaviors.hotkeysForSave` (attached with `once('hotkeys-for-save', 'HTML', context)`):

## Key handling

- `keydown`: if `e.keyCode === 83 && (e.ctrlKey || e.metaKey)` → `e.preventDefault()` (blocks the
  browser "Save As" dialog) then `clickOnSubmitButton()`.
- `keyup`: on keyCode 83, re-arm `clickAllowed` (debounce so holding Ctrl+S submits once).

## Button selection order (`clickOnSubmitButton`)

1. First try a "Save and continue"–style button, in order:
   `#edit-save-continue`, `#edit-next`, `#edit-continue` (via a combined `querySelector`).
2. If none found, fall back to plain Save buttons:
   `#edit-submit`, `#edit-save`, `#edit-actions-save`, `#edit-return`, `#edit-actions-submit`,
   `#edit-delete-entities`, then `[data-drupal-selector="edit-submit"]`,
   `[data-drupal-selector="edit-actions-submit"]`, `[data-drupal-selector="edit-save"]`.
3. Click the first match (the `data-drupal-selector` entries cover admin themes like **Gin**
   whose ids are awkward, e.g. `edit-submit--2--gin-edit-form`).

## CKEditor

If `window.CKEDITOR` exists, on `instanceCreated` → `contentDom` it attaches the same
keydown/keyup listeners inside the editor's editable, because a focused editor would otherwise
capture the keystroke before the document handler.

## Attachment

`hotkeys_for_save_page_attachments()` adds the library to every page **only when**
`\Drupal::currentUser()->hasPermission('use hotkeys for save')`. There is nothing to configure;
behaviour is fixed in JS.
