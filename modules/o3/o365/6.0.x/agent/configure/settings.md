# Configure: app registration, credentials & connectors

The module ties three things together: **client credentials in `settings.php`**, a
**`o365_connector` config entity** per Microsoft app registration, and a small
**`o365.settings`** config object.

## 1. Credentials in settings.php (NOT config/UI)

`HelperService::getApiConfig(?string $config_id = 'default')` reads `Settings::get('o365')`
and returns `$settings['o365'][$config_id]`. Structure (6.0.x is multi-connector — keyed by the
connector machine name):

```php
// settings.php
$settings['o365'] = [
  'default' => [
    'client_id'     => '…',   // Azure app (client) ID
    'client_secret' => '…',   // Azure client secret value
    'tenant_id'     => '…',   // directory (tenant) ID, or 'common' / 'organizations'
  ],
  // 'another_connector' => [ 'client_id' => …, 'client_secret' => …, 'tenant_id' => … ],
];
```

`O365Connector::getClientId()/getClientSecret()/getTenantId()` proxy to this array;
`getTenantId()` falls back to `'common'` when unset. `hook_requirements()` (`o365.install`,
runtime phase) reports an error for every connector entity that lacks a matching
`$settings['o365'][<id>]` block or is missing any of the three keys.

The Azure app must register the redirect URI shown on the connector list —
`https://<host>/o365/callback/<connector_id>` (route
`o365_sso.login_callback_controller_callback`, provided by the `o365_sso` submodule).

## 2. The `o365_connector` config entity

`@ConfigEntityType(id = "o365_connector")` — `src/Entity/O365Connector.php`.
`config_prefix: o365_connector`, `admin_permission: administer o365 connectors`.
`config_export`: `id`, `label`, `status`, `redirect_login`, `auth_scopes`.

| Route (machine name) | Path | Permission |
|---|---|---|
| `entity.o365_connector.collection` | `/admin/config/system/o365/settings/o365-connectors` | `access o365 connectors` |
| `entity.o365_connector.add_form` | `…/add` | `create o365 connector` |
| `entity.o365_connector.edit_form` | `…/{o365_connector}` | `edit o365 connector` |
| `entity.o365_connector.delete_form` | `…/{o365_connector}/delete` | `delete o365 connector` |

Edit form (`O365ConnectorForm`) fields:

| Field | Meaning |
|---|---|
| `label` / `id` | Human label + machine name (machine name = the `settings.php` key) |
| `redirect_login` | Absolute URL the user is sent to after a successful sign-in (required) |
| `auth_scopes` | Space-separated Graph scopes; `offline_access` is added automatically, and each `hook_o365_auth_scopes()` scope is appended |
| `status` | Enabled checkbox |

The list builder (`O365ConnectorListBuilder`) also shows the per-connector **Callback URL** to
paste into Azure. Access is enforced by `O365ConnectorAccessControlHandler` (view/update/delete
each OR the admin permission).

Create via PHP:

```php
\Drupal::entityTypeManager()->getStorage('o365_connector')->create([
  'id' => 'default',
  'label' => 'Microsoft 365',
  'status' => TRUE,
  'redirect_login' => 'https://www.example.com/user',
  'auth_scopes' => 'User.Read Mail.Read',
])->save();
```

## 3. The `o365.settings` config object

Form `o365.settings_form` (`\Drupal\o365\Form\SettingsForm`) at
`/admin/config/system/o365/settings`, permission `access o365 settings page`. One key:

| Key | Type | Effect |
|---|---|---|
| `verbose_logging` | boolean | Enables extra debug logging to the `o365` log channel |

```bash
drush cset o365.settings verbose_logging 1 -y
drush role:perm:add site_admin 'access o365 settings page'
```

## 4. Authorization-scopes report

Route `o365.auth_scopes` → `/admin/reports/o365-auth-scopes`
(`O365AuthScopesController::build`, permission `access o365 settings page`) renders the effective
set of Graph scopes (theme `o365_auth_scopes_table`) that `HelperService::getAuthScopes()` will
request. There is also a Graph **Debugger** form at `o365.debugger`
(`/admin/config/system/o365/debugger`, permission `access o365 debugger page`) that runs a GET
against a Graph endpoint you type and prints the JSON.

## 5. Upgrade note (5.x → 6.0.x)

`o365_update_10001` installs the `o365_connector` entity type; `o365_update_10002` creates a
`default` connector from the old `o365.api_settings` config; `o365_update_10003` +
`o365_post_update_remove_api_settings_config` delete the legacy `o365.api_settings`. The old flat
`$settings['o365']['api_settings'][...]` layout must be reshaped to the connector-keyed layout
above. Run `drush updatedb` after upgrading.

## Submodules (enable only what you need)

All depend on `o365` (some also on `o365_sso`). Enable with `drush en <name> -y`.

| Submodule | Purpose |
|---|---|
| `o365_sso` | Sign in to Drupal with Microsoft 365 (delegated login + callback + role sync trigger) |
| `o365_sso_user` | Sync Graph profile data (fields, picture) onto the Drupal user/profile on login |
| `o365_profile` | Profile & persona data, persona/Teams-links blocks, a Views field |
| `o365_outlook_mail` | Latest / unread Outlook mail blocks + page |
| `o365_outlook_calendar` | Calendar block + "add node to my Outlook calendar" |
| `o365_onedrive` | Recent / shared OneDrive files blocks + listing |
| `o365_sharepoint_file` | SharePoint file-search block |
| `o365_sharepoint_field` | Field type/widget/formatter linking to SharePoint files |
| `o365_contacts` | Contact-search block |
| `o365_groups` | Link Drupal Group entities to Microsoft Teams; list Team files |
| `o365_teams` | Send Teams messages / start chat or call from Drupal |
| `o365_links` | Block of links to the user's Office apps |
| `o365_rest` | REST resource `/o365/get-access-token` |
| `o365_profile_rest` | REST resource exposing profile/persona data |

## Config schema

`config/schema/o365.schema.yml` defines `o365.role_settings` (see
[role-mapping.md](role-mapping.md)). The `o365_connector` entity and `o365.settings` are covered by
their own schema/entity definitions.
