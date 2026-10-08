<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Key Save adds a keyboard shortcut (Ctrl-S / Cmd-S) to Drupal configuration and entity forms that submits the form instead of triggering the browser's Save-page dialog, by programmatically clicking the form's primary submit button.

---

The module is almost entirely a `hook_form_alter` plus a small JS behavior. For each form it decides whether to attach the `keysave/listen` library: forms whose `form_id` is in the configured `exclude_forms` list are skipped; forms in the `include_forms` list are always included; otherwise the form is included automatically if its form object is a subclass of `Drupal\Core\Form\ConfigFormBase` or `Drupal\Core\Entity\EntityForm`. The JS (`js/listen.js`, depends on `core/once`) locates the primary submit button by trying, in order, the selectors `edit-submit`, `edit-actions-submit`, `edit-save`, and `edit-save-continue`; if none is found it does nothing. It listens for `keydown` where Ctrl or Cmd is held with the `S` key, calls `.click()` on that button, and prevents the browser default. It also integrates with CKEditor: on editor instance-ready it binds the same Ctrl+83 key combo inside the editor to click the submit button. Because it triggers a real button click, existing form validation and submit handlers run normally. A settings form at `/admin/config/user-interface/keysave` (permission `administer site configuration`) edits the include/exclude form-id lists, stored in `keysave.settings`. The default `include_forms` covers a handful of admin forms that don't extend the config/entity base classes (e.g. `block_admin_display_form`, `system_modules`, `user_admin_permissions`).

---

- Save an entity edit form (node, media, term, user) with Ctrl-S / Cmd-S instead of scrolling to the button.
- Submit any config form (extends `ConfigFormBase`) with the keyboard shortcut automatically.
- Speed up repetitive admin work (permissions, modules list) by saving via keyboard.
- Save while the cursor is inside a CKEditor rich-text field using Ctrl-S.
- Override the browser's default "save this page" dialog on Drupal forms.
- Add keysave to a specific non-standard form by adding its `form_id` to the include list.
- Disable keysave on a specific form by adding its `form_id` to the exclude list.
- Enable saving on the block layout form (`block_admin_display_form`) via the shipped default includes.
- Enable saving on the modules install/uninstall forms via the shipped defaults.
- Enable saving on the permissions form (`user_admin_permissions`) via the shipped defaults.
- Keep normal validation/submit behavior since the shortcut just clicks the real submit button.
- Give content editors a faster save workflow without any custom code.
- Apply consistently across all entity add/edit forms site-wide.
- Configure include/exclude lists per environment via config export/import.
- Support the `edit-save-continue` button (e.g. some workflow/moderation forms) as a save target.
- Provide an IDE-like save gesture for site builders working in the admin UI.
