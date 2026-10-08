<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# stop_admin — configuration & operation

Everything the module ships. Source: `stop_admin.module`, `src/Form/StopAdminConfigForm.php`,
`stop_admin.routing.yml`, `stop_admin.links.menu.yml`, `config/install/stop_admin.settings.yml`,
`config/schema/stop_admin.schema.yml`, `stop_admin.install`.

## Install / enable

```
composer require drupal/stop_admin
drush en stop_admin -y
```

No dependencies beyond core. On enable, `config/install/stop_admin.settings.yml` writes the
config object `stop_admin.settings` with `disabled: false` and `block_admin_role: false` — i.e.
the block is active and covers **only user 1** by default.

> Before enabling, ensure you have a named administrator account (not user 1) that can still sign
> in, and Drush access for recovery. See the drupal.org docs for recovery details.

## Config object `stop_admin.settings`

Schema (`config/schema/stop_admin.schema.yml`, `type: config_object`):

| Key | Type | Default | Meaning |
| --- | --- | --- | --- |
| `disabled` | boolean | `false` | When `true`, `stop_admin_form_alter()` does **not** attach the validate callback, so the block is entirely off. |
| `block_admin_role` | boolean | `false` | When `true`, the block also rejects any user holding the role flagged `is_admin` (set at `/admin/people/role-settings`). |

`disabled` has **no UI control** — the settings form exposes only `block_admin_role`. `disabled`
is meant to be toggled programmatically (e.g. a config override in `settings.php` so you can still
log in as user 1 on a DEV/STAG environment); see drupal.org's *custom-logic-for-disabling* doc.

Read either value: `\Drupal::config('stop_admin.settings')->get('block_admin_role')`.

## Settings form / route / permission / menu

- Form: `Drupal\stop_admin\Form\StopAdminConfigForm` (extends `ConfigFormBase`, form id
  `stop_admin_settings`, `SETTINGS = 'stop_admin.settings'`). `buildForm()` renders one checkbox
  `block_admin_role`; `submitForm()` saves it back to the config object.
- Route `stop_admin.settings` (`stop_admin.routing.yml`): path
  `/admin/config/people/stop_admin`, requirement `_permission: 'administer stop_admin
  configuration'`.
- Permission `administer stop_admin configuration` (declared with title *"Administer stop
  administrator login settings"*).
- Menu link `stop_admin.settings` (`stop_admin.links.menu.yml`) under parent `user.admin_index`
  (the *People* admin index).

## Enforcement mechanism

- `stop_admin_form_alter(&$form, $form_state, $form_id)`: if `!disabled` and `$form_id` is
  `user_login_form` or `user_login_block`, appends `_stop_admin_prevent_admin_login` to
  `$form['#validate']`.
- `_stop_admin_prevent_admin_login(&$form, &$form_state)`: on a resolved `uid`:
  - `uid === 1` → `setErrorByName('name', …)` with core's generic login-failure message.
  - else if `block_admin_role` → loop `user_role` storage, pick the enabled role where
    `$role->isAdmin()` is true, and if `User::load($uid)->hasRole($admin_role->id())`, set the same
    error.

## Install/update hooks

`stop_admin.install`: `stop_admin_update_8001()` seeds `disabled = FALSE`, and
`stop_admin_update_8002()` seeds `block_admin_role = FALSE`, for sites installed before those keys
existed. `hook_help()` (route `help.page.stop_admin`) documents the Drush-only recovery path.

## Operating notes

- To also block administrator-role users: visit `/admin/config/people/stop_admin`, check *Block
  administrator role*, save.
- Recovery when locked out of user 1: `drush uli --name "<username>"` for a one-time login link,
  or the password-recovery mail from `/user/password`.
- To temporarily allow user 1 again in a lower environment, override
  `stop_admin.settings:disabled` to `true` via config override rather than editing the stored
  config.
