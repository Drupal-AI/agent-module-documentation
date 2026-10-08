# API — `AzureProviderService`

Service id `phpmailer_oauth2.azure_provider` (class `src/Service/AzureProviderService.php`), constructed
with `@config.factory`, `@logger.factory`, `@request_stack`. It builds `TheNetworg\OAuth2\Client\Provider\Azure`
instances from `phpmailer_oauth2.settings` and exposes the auth options PHPMailer needs.

## Methods

- `getLoginProvider()` — Azure provider configured for the **interactive login** (includes
  `redirectUri = <scheme+host>/phpmailer_oauth2/aad-callback`). Used by `MsLoginController`.
- `getProvider()` — Azure provider for **token exchange / SMTP auth** (no redirect URI). Used by the
  callback controller and by `getAuthOptions()`.
- `getAuthOptions()` — returns the array PHPMailer SMTP consumes:
  ```php
  [
    'provider'     => $azureProvider,          // TheNetworg\OAuth2\Client\Provider\Azure
    'userName'     => $config->get('ms_email_address'),
    'clientSecret' => $config->get('ms_client_secret'),
    'clientId'     => $config->get('ms_client_id'),
    'refreshToken' => $config->get('ms_refresh_access_token'),
  ];
  ```

Both providers hardcode: `tenant = ms_tenant_id`, `urlAPI = https://graph.microsoft.com/`,
`API_VERSION = 1.0`, `defaultEndPointVersion = ENDPOINT_VERSION_2_0`, and
`scope = ['https://outlook.office.com/SMTP.Send', 'offline_access']`.

## Calling it

```php
$options = \Drupal::service('phpmailer_oauth2.azure_provider')->getAuthOptions();
// $options['provider'] can mint an access token from the stored refresh token.
```

`OptionProvider/HttpBasicAuthWithScope.php` is a small override of the league OAuth2
`HttpBasicAuthOptionProvider` that base64-encodes `client_id:client_secret` into a `Basic` auth header
and adds a `Scope` header on the token request (RFC 6749 §2.3.1) — an internal detail of the token call.
