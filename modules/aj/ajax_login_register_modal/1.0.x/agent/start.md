<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Ajax Login and Register Modal (ajax_login_register_modal) — agent index

Presents Drupal core's **user login, registration and password-reset forms in an AJAX modal /
off-canvas dialog**, and ships a **block of dialog-opening links** for anonymous visitors.
Package `Login`. Core `^8.8 || ^9 || ^10 || ^11`. License GPL-2.0-or-later. Version 1.0.1.
No composer deps, no module dependencies, **no permissions of its own**, no config schema, no Drush.

- **The whole mechanism, the block, and every config key + the 4 admin forms** →
  [config/settings.md](config/settings.md)

## What it actually is

- A `.module` file (procedural) that alters three core forms via `ajax_login_register_modal_form_alter()`:
  `user_login_form`, `user_register_form`, `user_pass`. It does **not** implement any authentication
  logic — core's own validate/submit handlers, flood control and form-token CSRF still run.
- One block plugin: `AjaxLoginRegisterModalBlock` (id **`ajax_login_register_modal_block`**), shown
  only when `currentUser->isAnonymous()`, outputting `use-ajax` dialog links.
- One custom AJAX command: `ReloadCommand` (`src/Ajax/ReloadCommand.php`) → JS `Drupal.AjaxCommands.reload`
  (`js/reload-commands.js`) which calls `window.location.reload()`.
- Four `ConfigFormBase` admin forms, all writing the single config object
  **`ajax_login_register_modal.settings`**.

## Mechanism (from source)

- `ajax_login_register_modal_enable_ajax_on_form()` wraps each form in
  `<div id="modal_form_wrapper{form_id}">`, injects a `#type => status_messages` region, adds a
  hidden `form_id` field, sets `actions.submit.#ajax.callback = ajax_login_register_modal_validate`,
  optionally overrides the submit `#value`, and attaches libraries
  `core/drupal.dialog.ajax`, `ajax_login_register_modal/dialog.alter`, `.../reload.commands`.
- `ajax_login_register_modal_validate()` (the #ajax callback, runs **after** core validation/submit):
  if `$form_state->hasAnyErrors()` → `ReplaceCommand('#modal_form_wrapper…', $form)` (inline errors);
  else → `ajax_login_register_modal_form_ajax_response()`.
- Success path opens `OpenModalDialogCommand` or `OpenOffCanvasDialogCommand` (per `ajax_modal_type`)
  with an admin-configured success title/message, then adds a redirect: `default` → a per-form core
  route (`user.page` / `<front>`), `custom` → the admin-set `…_redirect_url`, `refresh` → `ReloadCommand`.
- Routing: `/admin/config/{block,register,login,pass}/settings`, each `_permission: 'administer site
  configuration'`. Menu link under *Configuration → People* (`user.admin_index`); local tasks tie the
  four forms together.

See [config/settings.md](config/settings.md) for the full config-key list, the block, and caveats
(the `dialog.alter` override, `refresh` reload command).
