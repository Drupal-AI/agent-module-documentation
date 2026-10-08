# API: other public services

All services are defined in `o365.services.yml`. `o365.graph` has its own doc
([graph-service.md](graph-service.md)); the rest:

| Service id | Class (`src/…`) | Use it for |
|---|---|---|
| `o365.authentication` | `AuthenticationService` (impl `AuthenticationServiceInterface`) | The OAuth2 sign-in / token flow |
| `o365.helpers` | `HelperService` | API config lookup, scope building, date helpers |
| `o365.constants` | `ConstantsService` | Microsoft endpoint URLs, temp-store names |
| `o365.roles` | `RolesService` | Group→role mapping (see configure/role-mapping.md) |
| `o365.profile_render` | `PersonaRenderService` | Render a persona card render array |
| `o365.logger` | `O365LoggerService` (impl `O365LoggerServiceInterface`) | Module log channel + messenger |
| `o365.role_event` | `EventSubscriber\RoleEventSubscriber` | Internal: runs role sync on externalauth LOGIN |

## AuthenticationService (`o365.authentication`)

The delegated (authorization_code) flow. Public methods (interface):

```php
redirectToAuthorizationUrl(O365ConnectorInterface $connector);  // -> redirect to Microsoft
setAccessToken(string $code, O365ConnectorInterface $connector, string $redirect = '');
getAccessToken($login = TRUE);        // token from tempstore, refreshing if expired
saveAuthDataFromUrl(): void;          // capture token data passed back on the request
checkForOfficeLogin();                // externalauth id if signed in via o365_sso, else FALSE
getDataFromTempStore(string $name);   // read the module's private tempstore
```

Token data (`access_token`, `refresh_token`, `expires_on`, `connector_id`) is held in the private
tempstore (`o365.tempstore` / `o365AuthData`). `getAccessToken()` auto-refreshes an expired token
via the connector's `refresh_token`. Verbose logging (config `o365.settings:verbose_logging`) adds
debug output to the `o365` channel.

There is also an **app-only** path: the `oauth2_client` plugin
`Plugin/Oauth2Client/O365OAuth2Client` (id `o365`, `grant_type = client_credentials`,
`credential_provider = o365_sso`) which stores its token in state key
`oauth2_client_access_token-o365`. Use it for server-to-server (no signed-in user) Graph access.

## HelperService (`o365.helpers`)

```php
getApiConfig(?string $config_id = 'default'); // $settings['o365'][$config_id] or FALSE
getAuthScopes(?O365ConnectorInterface $connector, bool $asArray = FALSE);
   // merges the connector's scopes + hook_o365_auth_scopes() + always adds 'offline_access'
createIsoDate(int $timestamp): string;        // ISO8601 for Graph (…Z)
formatDate(string $date, string $tz = 'UTC', string $format = 'd-m-Y H:i'): string;
getTsFromDate(string $date, string $tz = 'UTC'): string;
strContains(string $haystack, string $needle): bool;
```

## ConstantsService (`o365.constants`)

```php
getAuthorizeUrl(O365ConnectorInterface $c); // https://login.microsoftonline.com/{tenant}/oauth2/v2.0/authorize
getTokenUrl(O365ConnectorInterface $c);     // …/{tenant}/oauth2/v2.0/token
getRedirectUrl();                           // https://<host>/o365/callback
getUserTempStoreName();                     // 'o365.tempstore'
getUserTempStoreDataName();                 // 'o365AuthData'
```

## PersonaRenderService (`o365.profile_render`)

```php
renderPersona(array $userData, string $type = 'small'): array; // #theme o365_persona_render_{type}, attaches o365/persona
getRandomPersonaColor(): string;                                // a Fluent UI persona color key
```

`$type` is `small` | `medium` | `large`; `$userData` is a Graph profile array.

## O365LoggerService (`o365.logger`)

```php
log($message, string $severity);   // logs to the 'o365' channel AND shows a Drupal message
debug(TranslatableMarkup $message); // debug-level log only
```
