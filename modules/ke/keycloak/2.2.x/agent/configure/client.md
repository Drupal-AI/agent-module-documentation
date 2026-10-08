<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Create & configure a Keycloak client

Keycloak has no settings form of its own. You create an **OpenID Connect client** whose
plugin is `keycloak`. UI: *Configuration → People → OpenID Connect*
(`/admin/config/people/openid-connect`, route `openid_connect.admin_settings`) → add client →
choose **Keycloak**.

## Config entity

- config name: `openid_connect.client.<id>` (owned by `openid_connect`, config_prefix `client`)
- exported fields: `id`, `label`, `plugin` (= `keycloak`), `settings`
- `settings` is validated by schema `openid_connect.client.plugin.keycloak`.

## Core settings (`settings`)

| key | meaning |
|---|---|
| `client_id` | Keycloak client id |
| `client_secret` | Keycloak client secret |
| `keycloak_base` | Keycloak server base URL, e.g. `https://id.example.com` (no trailing slash) |
| `keycloak_realm` | realm name, e.g. `master` |
| `iss_allowed_domains` | domains allowed to initiate SSO via ISS |
| `userinfo_update_email` | update the Drupal email from Keycloak on login (bool) |
| `kc_idp_hint` | default identity-provider hint forwarded to Keycloak |
| `debug` | log the OIDC flow (bool) |

Feature settings (`keycloak_sso`, `keycloak_sign_out`, `check_session`, `keycloak_i18n`,
`keycloak_groups`, `keycloak_locale_param`) are in [features.md](features.md).

## Derived endpoints

You never enter endpoints; `Keycloak::getEndpoints()` builds them from
`keycloak_base` + `/realms/` + `keycloak_realm`:

```
authorization  {base}/realms/{realm}/protocol/openid-connect/auth
token          {base}/realms/{realm}/protocol/openid-connect/token
userinfo       {base}/realms/{realm}/protocol/openid-connect/userinfo
end_session    {base}/realms/{realm}/protocol/openid-connect/logout
session_iframe {base}/realms/{realm}/protocol/openid-connect/login-status-iframe.html
```

## Create with drush (config only — no live IdP needed)

```php
\Drupal::entityTypeManager()->getStorage('openid_connect_client')->create([
  'id' => 'my_kc',
  'label' => 'My Keycloak',
  'plugin' => 'keycloak',
  'settings' => [
    'client_id' => 'drupal',
    'client_secret' => 'SECRET',
    'keycloak_base' => 'https://id.example.com',
    'keycloak_realm' => 'master',
    'userinfo_update_email' => true,
  ],
])->save();
```

Store the secret with the Key module in production rather than plain config.

## Read it back

```bash
drush cget openid_connect.client.my_kc
drush ev 'print_r(array_keys(\Drupal::entityTypeManager()->getStorage("openid_connect_client")->loadByProperties(["plugin"=>"keycloak"])));'
```
