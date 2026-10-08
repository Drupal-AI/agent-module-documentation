<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring a `windows_aad` client (the config entity)

There is **no dedicated admin form and no `configure` route** for this module. You
configure it through openid_connect's client UI or by writing an `openid_connect_client`
config entity directly.

- Entity type: `openid_connect_client` (owned by openid_connect).
- Config prefix / object name: `openid_connect.client.<id>` (e.g.
  `openid_connect.client.entra`).
- Admin UI: `/admin/config/services/openid-connect` → "+ Add OpenID Connect client" → pick
  **Windows Azure AD**.

## Config entity shape

```yaml
# openid_connect.client.entra.yml
langcode: en
status: true
dependencies:
  module:
    - openid_connect_windows_aad
id: entra
label: 'Microsoft Entra ID'
plugin: windows_aad          # <-- selects this module's plugin
settings:
  client_id: 'THE-AZURE-APP-CLIENT-ID'
  client_secret: my_secret_key     # a KEY entity id, not the raw secret
  iss_allowed_domains: ''
  authorization_endpoint_wa: 'https://login.microsoftonline.com/TENANT_ID/oauth2/v2.0/authorize'
  token_endpoint_wa: 'https://login.microsoftonline.com/TENANT_ID/oauth2/v2.0/token'
  end_session_endpoint: ''
  userinfo_endpoint_wa: ''
  map_ad_groups_to_roles: true
  group_mapping:
    method: 1                # 0 automatic, 1 manual
    mappings: |-
      administrator|11111111-2222-3333-4444-555555555555
    strict: false
  userinfo_graph_api_wa: 2   # Microsoft Graph v1.0
  userinfo_graph_api_use_other_mails: false
  userinfo_update_email: false
  hide_email_address_warning: false
  subject_key: sub
  prompt: {  }
```

See [../plugins/windows_aad.md](../plugins/windows_aad.md) for every `settings` key and its
meaning.

## Create it with drush (config level — no Azure needed)

```bash
drush php:eval '
  \Drupal::entityTypeManager()->getStorage("openid_connect_client")->create([
    "id" => "entra",
    "label" => "Microsoft Entra ID",
    "plugin" => "windows_aad",
    "settings" => [
      "client_id" => "THE-AZURE-APP-CLIENT-ID",
      "client_secret" => "my_secret_key",
      "authorization_endpoint_wa" => "https://login.microsoftonline.com/TENANT_ID/oauth2/v2.0/authorize",
      "token_endpoint_wa" => "https://login.microsoftonline.com/TENANT_ID/oauth2/v2.0/token",
      "map_ad_groups_to_roles" => TRUE,
      "group_mapping" => ["method" => 1, "mappings" => "administrator|GROUP-OBJECT-ID", "strict" => FALSE],
      "userinfo_graph_api_wa" => 2,
      "subject_key" => "sub",
    ],
  ])->save();
'
```

## Read / inspect it

```bash
drush config:get openid_connect.client.entra
drush php:eval '$c = \Drupal::entityTypeManager()->getStorage("openid_connect_client")->load("entra");
  print $c->getPluginId() . "\n"; print_r($c->get("settings"));'
```

## The client secret must be a Key entity

`client_secret` stores a **Key** id (the module depends on `drupal/key`), and the plugin
resolves it at token-exchange time via the Key repository. Create the key first, e.g. with
an env provider:

```bash
drush key:save entra_secret --label='Entra secret' --key-type=authentication \
  --key-provider=env --key-provider-settings='{"env_variable":"ENTRA_SECRET"}' \
  --key-input=none -y
```

then set `client_secret: entra_secret`.

## Notes / limits

- A **real login flow needs a live Microsoft Entra tenant** (valid client id, secret, and
  reachable endpoints). The config entity above is enough to register the client and is
  what config-level tests/verification check; it does not authenticate anyone by itself.
- Endpoints are tenant-specific. Standard v2 pattern:
  `https://login.microsoftonline.com/<tenant>/oauth2/v2.0/{authorize,token}`. Azure AD B2C
  uses a `https://<tenant>.b2clogin.com/.../oauth2/v2.0/authorize` host (auto-detected).
- `configure` in `data.json` is `null` — clients are managed under openid_connect's own
  routes, not a route this module provides.
