<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure — which forms get the shortcut

## Route
`keysave.settings` → `/admin/config/user-interface/keysave` (`KeysaveSettingsForm`),
permission `administer site configuration`. Two textareas ("Forms to Include" / "Forms to Exclude"),
one `form_id` per line; the submit handler trims each line and stores them as sequences.

## Config object `keysave.settings`
Schema `keysave.schema.yml` (both `sequence` of text, `orderby: value`).

| Key | Meaning |
|---|---|
| `include_forms` | Form IDs that should ALWAYS get keysave (used for forms that don't extend the base classes below). |
| `exclude_forms` | Form IDs that should NEVER get keysave (checked first, wins over everything). |

Shipped defaults (`config/install/keysave.settings.yml`):
`include_forms: [block_admin_display_form, bpmn_io_modeller, drupal_upgrade_status_summary_form,
system_modules, system_modules_uninstall, user_admin_permissions]`; `exclude_forms: ['']`.

## Attach logic (`keysave_form_alter`)
For every form, in order:
1. If `form_id` ∈ `exclude_forms` → return (no keysave).
2. If `form_id` ∈ `include_forms` → attach `keysave/listen`, return.
3. Else, if `$form_state->getFormObject()` is a subclass of `Drupal\Core\Form\ConfigFormBase` **or**
   `Drupal\Core\Entity\EntityForm` → attach `keysave/listen`.

So most config forms and all entity add/edit forms get the shortcut automatically; use `include_forms`
for special cases (plain `FormBase` admin forms) and `exclude_forms` to opt out.

## JS behavior (`js/listen.js`, library `keysave/listen`, dep `core/once`)
- Finds the primary submit button by trying `[data-drupal-selector]` = `edit-submit`,
  `edit-actions-submit`, `edit-save`, `edit-save-continue` (first match). If none, attaches nothing.
- On `keydown` with (`ctrlKey` || `metaKey`) and `code == 'KeyS'`: `save_btn.click()` + `preventDefault()`.
- CKEditor: on `instanceReady`, binds `CKEDITOR.CTRL + 83` (and keycode `1114195`) inside the editor to
  click `edit-submit` and cancel the event.
- Because it clicks the real button, normal validation and submit handlers run.
