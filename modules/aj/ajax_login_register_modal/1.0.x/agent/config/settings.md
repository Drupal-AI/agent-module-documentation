<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration, block & mechanism — ajax_login_register_modal

All settings live in one config object: **`ajax_login_register_modal.settings`** (install defaults in
`config/install/ajax_login_register_modal.settings.yml`). There is **no `config/schema/`**, so the object
is unschemad (values save via `ConfigFormBase::submitForm` loops; export/translation UI will warn about
missing schema). No `*.permissions.yml` — the module defines no permissions of its own.

## Install / enable

`drush en ajax_login_register_modal -y`. No dependencies beyond core. To use the links block, place the
**"Ajax Login, Register, Password Reset Modal Links Block"** (id `ajax_login_register_modal_block`) in a
region via *Structure → Block layout*. The three core forms become AJAX-modal automatically once the
module is enabled (via `hook_form_alter`); no per-form opt-in.

## The four admin forms (routes)

All under `_permission: 'administer site configuration'`, all editing `ajax_login_register_modal.settings`:

| Route | Path | Form class |
|---|---|---|
| `ajax_login_register_modal.block_config` | `/admin/config/block/settings` | `BlockConfigForm` |
| `ajax_login_register_modal.register_config` | `/admin/config/register/settings` | `RegisterConfigForm` |
| `ajax_login_register_modal.login_config` | `/admin/config/login/settings` | `LoginConfigForm` |
| `ajax_login_register_modal.pass_config` | `/admin/config/pass/settings` | `PasswordResetConfigForm` |

`info.yml` `configure:` points at `ajax_login_register_modal.block_config`. A menu link (under
*Configuration → People*, `user.admin_index`) plus four local tasks link them. Each `submitForm()` loops
`$form_state->getValues()` and writes every value straight into the config object with the field key as
the config key.

## Config keys

Global / block (`BlockConfigForm`):
- `enabled_link` — checkboxes, which of `login` / `register` / `pass` links the block renders. Default
  `['login','register','pass']`.
- `links_display_style` — `vertical` (each link wrapped in `<div class="link-item">`) or `horizantol`
  [sic]. Default `vertical`.
- `ajax_modal_type` — `modal` (`OpenModalDialogCommand`), `dialog` (non-modal), or `off_canvas`
  (`OpenOffCanvasDialogCommand`). Default `modal`.
- `login_button` / `register_button` / `pass_button` — link text (defaults *Login* / *Register* /
  *Reset Your Password*). Note: the block itself currently renders each link with literal text
  `"Link Text Here"` (`AjaxLoginRegisterModalBlock::build()`), i.e. these `*_button` values are not
  actually applied to the block links in 1.0.1.
- `login_progress_message` / `register_progress_message` / `user_pass_progress_message` — AJAX throbber
  text (note: `BlockConfigForm` saves login/register under the keys
  `user_login_form_progress_message` / `user_register_form_progress_message`, which are the keys the
  `hook_form_alter` throbber actually reads via `{form_id}_progress_message`).

Per-form (login = `LoginConfigForm`, register = `RegisterConfigForm`, reset = `PasswordResetConfigForm`).
Keys are prefixed by the form id (`user_login_form` / `user_register_form` / `user_pass`) or the short
link name (`login` / `register` / `pass`):
- `{login|register|pass}_modal_title`, `{…}_modal_width` (px), `{…}_modal_height` (px),
  `{…}_modal_drupal_auto_buttons` (checkbox — when set, `drupalAutoButtons` is sent as FALSE).
- `{form_id}_disable_modal_title` — when true, `js/dialog-alter.js` nulls the dialog title
  (via `drupalSettings.disable_modal_title`).
- `{form_id}_action_button` — overrides the submit button `#value`.
- `{form_id}_success_title` / `{form_id}_success_message` — shown in the success dialog on a
  no-error submit.
- In-modal links: `user_login_form_register_link`, `user_login_form_pass_link`,
  `user_register_form_login_link`, `user_register_form_pass_link`, `user_pass_register_link`,
  `user_pass_login_link` — booleans that add extra dialog links inside a form
  (`ajax_login_register_modal_enabled_links()`).
- Redirect: `{form_id}_redirect_settings` = `default` | `custom` | `refresh`, and
  `{form_id}_redirect_url` (used only when `custom`; the description invites internal or external URLs).
  Defaults are all `default` with empty custom URL.

## Success / redirect flow (`ajax_login_register_modal_form_ajax_response`)

Runs only when the submit had no validation errors. It opens the configured dialog type with the
success title/message, then:
- `default` → `RedirectCommand` to a per-form core route: `user_login_form` → `user.page`,
  `user_pass` → `<front>`, `user_register_form` → `<front>`.
- `custom` → `RedirectCommand($…_redirect_url)`.
- `refresh` → `ReloadCommand` (custom command; JS `Drupal.AjaxCommands.reload` → `window.location.reload()`).

## Block plugin

`AjaxLoginRegisterModalBlock` (`src/Plugin/Block/…`): injects `config.factory` + `current_user`.
`build()` returns nothing (empty) for authenticated users; for anonymous users it emits one `use-ajax`
Link per `enabled_link`, targeting `Url::fromRoute('user.{link}')` with `data-dialog-type` /
`data-dialog-renderer` and JSON-encoded `data-dialog-options` (title/width/height/drupalAutoButtons),
and attaches `core/drupal.dialog.ajax`.

## Caveats

- `hook_library_info_alter()` in the `.module` is effectively a **no-op** — every line that would swap
  `core/drupal.dialog`'s JS is commented out. The `dialog.alter` library (`js/dialog-alter.js`) is instead
  attached directly to the altered forms; it redefines `Drupal.dialog` and contains bare `FALSE`/`TRUE`/`NULL`
  identifiers (not PHP-cased JS `false`/`true`/`null`), which will throw at runtime on browsers — treat the
  title-disable / body-scroll-lock behaviour as unreliable in 1.0.1.
- The block renders link text as the literal string `"Link Text Here"` (see above); the `*_button` config
  is not wired to it in this release.
- Auth remains core's: because the `#ajax` callback fires after normal form processing, core's login flood
  control, password verification, registration validation and form-token CSRF all still apply.
