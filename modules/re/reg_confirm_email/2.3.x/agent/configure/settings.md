# Configure Registration Confirm Email Address

The `configure` route is `entity.user.admin_form` — i.e. the **core** account settings page at
`admin/config/people/accounts`. The module adds a **"Confirm email address"** details section
there (`hook_form_user_admin_settings_alter`) with two controls, saved by an appended submit
handler into `reg_confirm_email.settings`.

Source: `reg_confirm_email.module` (all behavior is procedural form-alter code).

## Settings

| Config key | Form control | Default | Meaning |
|---|---|---|---|
| `mail_confirm` | checkbox "Use two e-mail fields on registration form" | `FALSE` | Master switch. When TRUE the confirm field is added to the register form. |
| `mail_desc` | textfield "Confirm Email Description" | `'Please re-type your e-mail address to confirm it is accurate'` | Help text (`#description`) shown under the confirm field. |

Config object `reg_confirm_email.settings` (schema `reg_confirm_email.schema.yml`); default
values ship in `config/install/reg_confirm_email.settings.yml`.

## Enable / configure with Drush (no UI needed)

```bash
ddev drush cset reg_confirm_email.settings mail_confirm 1 -y
ddev drush cset reg_confirm_email.settings mail_desc 'Please re-enter your email address' -y
```

## Runtime behavior (what enabling it does)

- `hook_form_user_register_form_alter`: only when `mail_confirm` is TRUE **and** the form has an
  `account.mail` element, it inserts `conf_mail` (`#type => email`, `#required => TRUE`,
  `#description => mail_desc`) immediately after `mail` via `_reg_confirm_email_array_insert_after()`,
  and appends `_reg_confirm_email_user_register_validate` to `#validate`.
- Validation: `_reg_confirm_email_user_register_validate()` sets a form error on `conf_mail`
  ("Your e-mail address and confirmed e-mail address must match.") when
  `$form_state->getValue('mail') !== $form_state->getValue('conf_mail')`.

## Scope / non-goals

- No permissions, no Drush commands, no plugins, no services, no submodules.
- It does **not** modify account activation/approval, email verification, one-time-login tokens,
  or the login flow — it purely adds a client-visible confirm field and an equality check. There
  is no account-activation bypass or token handling here to worry about.
