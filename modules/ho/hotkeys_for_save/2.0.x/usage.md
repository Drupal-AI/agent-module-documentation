<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Hotkeys for Save lets users press **Ctrl+S** (Windows/Linux) or **Cmd+S** (Mac) to trigger the "Save" button on a Drupal form instead of scrolling down to click it, while suppressing the browser's native "Save As" dialog.

---

The module is almost entirely a small JavaScript behavior (`hotkeys_for_save.js`). It listens for `keydown` where `keyCode === 83` and `ctrlKey`/`metaKey` is held, calls `preventDefault()` (so the browser "Save As" dialog never opens), and clicks a submit button on the page. Button selection is prioritized: it first looks for a "Save and continue"–style button (`#edit-save-continue`, `#edit-next`, `#edit-continue`); if none is found it falls back to the plain Save buttons (`#edit-submit`, `#edit-save`, `#edit-actions-save`, `#edit-return`, `#edit-actions-submit`, `#edit-delete-entities`) and to `data-drupal-selector` variants (`edit-submit`, `edit-actions-submit`, `edit-save`) which cover admin themes like **Gin** whose generated ids are awkward. A key-up handler debounces so holding the keys doesn't submit repeatedly, and extra listeners are attached inside **CKEditor** instances (via the `CKEDITOR` global) because a focused editor would otherwise swallow the keystroke. The library (`hotkeys_for_save/hotkeys_for_save`, depending on `core/drupal` + `core/once`) is attached in `hook_page_attachments()` **only when the current user has the `use hotkeys for save` permission**, so the shortcut is off for anyone without it. That single permission is granted to the `administrator` role on install. There is no settings form, no configuration, no Drush, and no configure route — enabling the module and granting the permission is all there is.

---

- Save a node edit form with Ctrl+S instead of scrolling to the Save button.
- Save a long configuration form (e.g. permissions) with Cmd+S on a Mac.
- Trigger a "Save and continue" wizard step with the keyboard.
- Speed up repetitive content editing for editors who save constantly.
- Submit an add-content form ("Create new account", "Finish", "Continue & edit", …) via hotkey.
- Save a block, taxonomy term, or menu link edit form from the keyboard.
- Work efficiently in the Gin admin theme (handled via data-drupal-selector fallbacks).
- Save while the cursor is inside a CKEditor rich-text field (CKEditor listeners are attached).
- Prevent the browser "Save As" dialog from popping up when pressing Ctrl+S on an admin page.
- Grant the shortcut only to trusted editors/admins via the `use hotkeys for save` permission.
- Keep the shortcut off for anonymous/ordinary users by not granting the permission.
- Give a specific editorial role the save-hotkey by adding the permission to that role.
- Save a Views configuration form with the keyboard.
- Save field/display configuration ("Save and manage fields") without mouse.
- Reduce RSI/mouse travel for power users doing bulk content work.
- Standardise a keyboard-first editing workflow across an editorial team.
- Submit a confirm/delete form (`#edit-delete-entities`) with the hotkey where present.
- Enable the feature site-wide instantly (just install + permission — no config).
- Avoid building a custom keyboard-shortcut solution for the Save button.
