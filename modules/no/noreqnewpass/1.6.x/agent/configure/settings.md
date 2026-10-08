<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# noreqnewpass — configure

## Settings form / route

- Route name: `noreqnewpass.settings_form` (the `configure` route in `noreqnewpass.info.yml`).
- Path: `/admin/config/people/noreqnewpass`.
- Access: `_permission: 'administer noreqnewpass'`.
- Form class: `Drupal\noreqnewpass\Form\NoReqNewPassSettingsForm` (form id `noreqnewpass_admin_settings`).
- A menu link (`noreqnewpass.links.menu.yml`) places it under the People admin index (`user.admin_index`).

The form has one field: a checkbox "Disable Request new password link". On submit it saves
the boolean and calls `router.builder->rebuild()` so the route-access change takes effect
immediately.

## Config object

Config object: `noreqnewpass.settings_form` (schema type `config_object`).

| Key | Type | Install default | Effect when TRUE |
|---|---|---|---|
| `noreqnewpass_disable` | boolean | `false` | Denies `/user/password`, alters the login form validator, and hides the login-block reset link. |

Install default ships in `config/install/noreqnewpass.settings_form.yml` as
`noreqnewpass_disable: false` (module inert out of the box).

## Read / set with drush

```bash
# read the current value
drush config:get noreqnewpass.settings_form noreqnewpass_disable

# enable (disable the password-reset flow) — rebuild routes so route access updates
drush config:set noreqnewpass.settings_form noreqnewpass_disable true -y
drush cr

# disable the module's effect (back to core behavior)
drush config:set noreqnewpass.settings_form noreqnewpass_disable false -y
drush cr
```

Setting via the UI triggers a router rebuild automatically; when you set the config
directly with drush, run `drush cr` (or `drush router:rebuild`) so the `user.pass` route
access requirement is re-evaluated.

## Drupal 7 migration

`migrations/noreqnewpass_settings.yml` (id `newreqnewpass_settings`) maps the legacy D7
`noreqnewpass_disabled` variable into `noreqnewpass.settings_form:noreqnewpass_disable`
(default TRUE if the source is absent).
