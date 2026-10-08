<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings, config object, routes & permissions

## Install / enable

```
composer require drupal/authnet_cim_manager
drush en authnet_cim_manager -y
```

Composer pulls in the Authorize.Net PHP SDK `authorizenet/authorizenet:^2.0`
(`composer.json` `require`). No Drupal-module dependencies (`.info.yml` has none). Core
`^9 || ^10 || ^11`.

## Configuration form — `SettingsForm`

`src/Form/SettingsForm.php`, a `ConfigFormBase`, form id `authnet_cim_manager_settings`.
Editable config: **`authnet_cim_manager.settings`** (`getEditableConfigNames()`). Three fields,
saved verbatim in `submitForm()`:

| Config key        | Widget                                  | Meaning                                              |
|-------------------|-----------------------------------------|------------------------------------------------------|
| `api_id`          | textfield                               | Authorize.Net **API Login ID** (used as SDK `setName`) |
| `transaction_key` | textfield                               | Authorize.Net **Transaction Key** (SDK `setTransactionKey`) |
| `environment`     | select `development` \| `production`    | Chooses SDK endpoint: `production` → `ANetEnvironment::PRODUCTION`, anything else → `SANDBOX` |

There is **no `config/install` default** and **no `config/schema`** in the project, so the config
object starts empty and is untyped (schema-less). Values persist in the active config /
config-export.

## Route & permission

`authnet_cim_manager.routing.yml`:

- `authnet_cim_manager.settings` → `/admin/config/system/authcim`, `_form: SettingsForm`,
  `_permission: 'administer site configuration'`. Titled "Authorise.Net Settings".
- Menu link (`authnet_cim_manager.links.menu.yml`) "Auth.Net Config" under
  `system.admin_config_system`, weight 10.

## Operating it

1. Get an **API Login ID** and **Transaction Key** from the Authorize.Net Merchant Interface
   (Account → Security Settings → API Credentials & Keys).
2. Go to `/admin/config/system/authcim`, enter both, set **Environment** to `development` while
   testing against the Authorize.Net sandbox, `production` when live, and save.
3. Place the "CIM Creation Form" block or link users to
   `/authnet-cim-manager/cim-creation-fom` — see [../api/cim-creation.md](../api/cim-creation.md).

The module reads these three keys directly with
`$this->configFactory->get('authnet_cim_manager.settings')->get(...)` inside
`CreateCimController` on every SDK call.
