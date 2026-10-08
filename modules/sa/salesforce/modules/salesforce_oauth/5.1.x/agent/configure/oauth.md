# OAuth setup & default provider

## The authorization

An OAuth authorization is a `salesforce_auth` config entity with `provider` = `oauth`. Create
and authorize it in the UI at `salesforce.auth_config` (Salesforce → Authorization). Provider
settings:

| Key | Meaning |
|---|---|
| `consumer_key` | The Salesforce connected app's consumer key. |
| `consumer_secret` | The connected app's consumer secret. |
| `login_url` | `https://login.salesforce.com` (prod) or `https://test.salesforce.com` (sandbox). |

Completing the authorization redirects to Salesforce, then back to the callback route
`salesforce.oauth_callback`, storing the access/refresh token via
`salesforce.auth_token_storage` (State).

> Creating and completing an OAuth authorization requires the live Salesforce org and a
> browser, so it cannot be fully scripted offline. What **is** local config is which
> authorization the suite uses by default.

## Set the default provider (local)

The suite uses the authorization named by `salesforce.settings.salesforce_auth_provider`:
```bash
drush cget salesforce.settings salesforce_auth_provider
drush cset salesforce.settings salesforce_auth_provider my_oauth -y
```
```php
\Drupal::configFactory()->getEditable('salesforce.settings')
  ->set('salesforce_auth_provider', 'my_oauth')
  ->save();
```

## Manage the token (Drush)

```bash
drush salesforce:list-providers
drush salesforce:refresh-token my_oauth
drush salesforce:revoke-token my_oauth
```

## OAuth vs JWT

Use OAuth when an admin can click through an interactive consent; use `salesforce_jwt` for
unattended server-to-server auth with a signing key.
