<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings form, config, route & permission

## Install & enable

```bash
composer require drupal/dropfort_update
drush en dropfort_update -y
```

Only dependency is core **`update`** (declared in `dropfort_update.info.yml`; Drush enables it
automatically). No sub-modules, no third-party PHP libraries.

## Route, permission, menu

- Route **`dropfort_update.settings`** (`dropfort_update.routing.yml`): path
  `/admin/config/services/dropfort_update`, `_form: DropfortUpdateSettingsForm`, title
  *"Dropfort Update Settings"*, `_admin_route: TRUE`.
- Requirement: `_permission: 'administer dropfort update'` — the module's single permission, defined
  in `dropfort_update.permissions.yml` (*"Administer Dropfort Update"*). This is the only access gate;
  there is no inbound/callback route.
- Menu link `dropfort_update.settings` (`dropfort_update.links.menu.yml`) sits under
  `system.admin_config_services` (*Configuration → services*), weight 99.

## Settings form

`src/Form/DropfortUpdateSettingsForm.php` extends `ConfigFormBase`; `getFormId()` =
`dropfort_update.settings`; editable config = `dropfort_update.settings`. `buildForm()` renders three
fields:

| Field | `#type` | Required | Backing config key | Notes |
|---|---|---|---|---|
| **Site Key** | `textfield` | yes | `site_key` | Identifier issued in the Dropfort site interface. |
| **Status Auth Token** | `password` | no | `site_token` | Auth token from Dropfort. *"Leave blank to keep existing value."* |
| **Dropfort URL** | `url` | yes | `dropfort_url` | Dropfort instance base URL; default `https://api.dropfort.com`. |

`submitForm()` always saves `site_key` and `dropfort_url`, and saves `site_token` **only when the
submitted value is non-empty** (so leaving the password field blank preserves the stored token). It
then calls `dropfort_update_send_status()` to push a report immediately — see
[../api/reporting.md](../api/reporting.md).

## Config object `dropfort_update.settings`

Read by the form and by `dropfort_update_send_status()`: **`site_key`**, **`site_token`**,
**`dropfort_url`**. Values live in the `dropfort_update.settings` config object (standard Drupal
config storage), so they are part of config export/sync.

`config/install/dropfort_update.settings.yml` ships these defaults:

```yaml
site_token: ''
policy_id: ''
allow_unencrypted: false
timestamp_window: 900
show_moderation_notice: true
dropfort_url: 'https://api.dropfort.com'
cache_lifetime: 43200
```

Only `site_token` and `dropfort_url` here are consumed by the 2.1.x code; `site_key` is added when the
form is first saved. The remaining keys (`policy_id`, `allow_unencrypted`, `timestamp_window`,
`show_moderation_notice`, `cache_lifetime`) are **not referenced anywhere in this module's source** —
they are inert defaults. No `config/schema/` is shipped, so strict config-schema tooling has no schema
for this object.
