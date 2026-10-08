# Set up a JWT authorization

A JWT authorization is a `salesforce_auth` config entity with `provider` = `jwt` (or
`jwt_govcloud`). Create/authorize it in the UI at `salesforce.auth_config`, or in code.

## Provider settings (`provider_settings`)

| Key | Meaning |
|---|---|
| `login_url` | `https://login.salesforce.com` (production) or `https://test.salesforce.com` (sandbox). Default: `https://test.salesforce.com`. |
| `consumer_key` | The Salesforce connected app's consumer key. |
| `username` | The Salesforce username to authenticate as (impersonate). |
| `encrypt_key` | The **Key module** entity id holding the private key used to sign the JWT assertion. |

## Create in code

```php
$auth = \Drupal::entityTypeManager()->getStorage('salesforce_auth')->create([
  'id' => 'prod_jwt',
  'label' => 'Production (JWT)',
  'provider' => 'jwt',
  'provider_settings' => [
    'login_url' => 'https://login.salesforce.com',
    'consumer_key' => '3MVG9...',
    'username' => 'integration@example.com',
    'encrypt_key' => 'salesforce_jwt_private_key',   // a Key entity id
  ],
]);
$auth->save();
```

Read it back:
```php
$auth->getPluginId();                             // 'jwt'
$auth->get('provider_settings')['login_url'];
```

## Make it the default

```bash
drush cset salesforce.settings salesforce_auth_provider prod_jwt -y
```

## The signing key

Store the connected app's private key as a Key entity (Key module) and reference its id in
`encrypt_key`. Rotating the key = updating that Key entity; the authorization is unchanged.

## Notes

- Creating the auth config entity is local (no network). **Authorizing** it (obtaining a
  token) exchanges a signed JWT with Salesforce and requires the live org + a valid
  connected app + key.
- `jwt_govcloud` is the same flow for Salesforce GovCloud endpoints.
