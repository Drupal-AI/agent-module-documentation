<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# PhpmailerOauth2 plugin type (XOAUTH2 authentication)

PHPMailer SMTP defines its own plugin type so other modules can add OAuth2/XOAUTH2 providers
without patching this module. Basic-auth remains the default; selecting any other
`smtp_authentication_type` value activates the matching OAuth2 plugin.

## Pieces

- **Manager service** `plugin.manager.phpmailer_oauth2` — `PhpmailerOauth2PluginManager`
  (`src/PluginManager/`), a `DefaultPluginManager` that discovers plugins in
  `Plugin/PhpmailerOauth2`, requires interface `PhpmailerOauth2PluginInterface`, uses annotation
  `@PhpmailerOauth2`, alter hook `phpmailer_oauth2_info`, cache key `phpmailer_oauth2`.
  (Interface `PhpmailerOauth2PluginManagerInterface` is an empty marker.)
- **Annotation** `@PhpmailerOauth2` (`src/Annotation/PhpmailerOauth2.php`) — two properties:
  `id` and `name` (a translatable label shown in the settings form's auth-type select).
- **Interface** `PhpmailerOauth2PluginInterface` extends `PluginInspectionInterface`,
  `ContainerFactoryPluginInterface`, `PluginFormInterface`, `ConfigurableInterface` and adds
  `getName()`, `getId()`, `getAuthOptions()`.
- **Base class** `PhpmailerOauth2PluginBase` (`src/Plugin/PhpmailerOauth2/`) extends `PluginBase`;
  implements `getName()`/`getId()` from the definition and stubs the configurable/plugin-form
  methods. Its `getAuthOptions()` returns `[]` — subclasses must override it.

## How auth is wired at send time

In `PhpMailerSmtp::smtpInit()`:

- `smtp_authentication_type === 'basic_auth'` → username/password path (see
  [../configure/phpmailer_smtp.md](../configure/phpmailer_smtp.md)).
- otherwise → `plugin.manager.phpmailer_oauth2->createInstance($smtp_authentication_type)`,
  then `$oauth = new \PHPMailer\PHPMailer\OAuth($plugin->getAuthOptions())`,
  `$this->setOAuth($oauth)`, `$this->AuthType = 'XOAUTH2'`, `$this->SMTPAuth = TRUE`.

So the OAuth options array (provider client, clientId/secret, refresh token, user email, etc.)
is entirely owned by the provider plugin's `getAuthOptions()` — **phpmailer_smtp stores none of
those credentials itself**; it only persists the chosen plugin id in `smtp_authentication_type`.
Where the plugin sources its client secret/refresh token is that provider module's concern.

## Add a provider

1. Create `Plugin/PhpmailerOauth2/MyProvider` extending `PhpmailerOauth2PluginBase` with
   `@PhpmailerOauth2(id = "my_provider", name = @Translation("My provider"))`.
2. Return the PHPMailer `OAuth` options from `getAuthOptions()` (a `provider` implementing the
   PHPMailer `OAuthTokenProvider`/`OAuthProviderInterface`, plus `clientId`, `clientSecret`,
   `refreshToken`, `userName`).
3. Clear caches; the provider appears in the settings form's "SMTP authentication type" select
   (`SettingsForm` builds the options from `getDefinitions()`), and is used once selected.

The contrib `drupal/phpmailer_oauth2` module ships an Azure provider as a working example.
