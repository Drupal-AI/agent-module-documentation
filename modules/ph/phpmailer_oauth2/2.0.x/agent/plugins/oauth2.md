# Plugins — the `azure` PhpmailerOauth2 plugin

The plugin **type** is defined by the `phpmailer_smtp` module (annotation `@PhpmailerOauth2`, base class
`Drupal\phpmailer_smtp\Plugin\PhpmailerOauth2\PhpmailerOauth2PluginBase`). This module contributes one
concrete plugin.

## `AzureOauth2` (`src/Plugin/PhpmailerOauth2/AzureOauth2.php`)

```php
/**
 * @PhpmailerOauth2(
 *   id = "azure",
 *   name = @Translation("Azure OAuth2"),
 * )
 */
```

- Implements `ContainerFactoryPluginInterface`; injects `phpmailer_oauth2.azure_provider`.
- `getAuthOptions()` simply delegates to `AzureProviderService::getAuthOptions()` (see
  [../api/service.md](../api/service.md)) — the array PHPMailer SMTP uses to build an XOAUTH2 token.

Select this plugin (`azure`) in the PHPMailer SMTP module's OAuth2 configuration.

## Adding another provider (e.g. Google)

Implement a new plugin class in your module's `src/Plugin/PhpmailerOauth2/` with a unique `id`, extend
`PhpmailerOauth2PluginBase`, and return a compatible `getAuthOptions()` array (a provider object plus
`userName`, `clientId`, `clientSecret`, `refreshToken`). You would supply your own settings + provider
service; this module's Azure service is Azure-specific and not reused for other providers.
