# Services

Declared in `cas.services.yml`.

## `cas.helper` — `Drupal\cas\Service\CasHelper`
Settings/logging helper: `getCasSettings()` (ImmutableConfig), `getCasSetting($key)`,
`getMessage($key)`, `log($level, $message, $context)`.

## `cas.validator` — `Drupal\cas\Service\CasValidator`
`validateTicket(string $ticket, array $service_params = []): CasPropertyBag` — validates a
service ticket against the CAS server and returns the user's CAS username + attributes.

## `cas.redirector` — `Drupal\cas\Service\CasRedirector`
`buildRedirectResponse(CasRedirectData $data, bool $force = FALSE)` — builds the redirect
to the CAS server login/gateway URL.

## `cas.user_manager` — `Drupal\cas\Service\CasUserManager`
Account provisioning and lookups (wraps `externalauth`):
- `register($authname, $local_username, $property_values = [])`
- `login(CasPropertyBag $property_bag, string $ticket)`
- `getCasUsernameForAccount($uid)` / `getUidForCasUsername($cas_username)`
- `setCasUsernameForAccount($account, $cas_username)` / `removeCasUsernameForAccount($account)`
- `getEmailForNewAccount(CasPropertyBag $bag)`

Other services: `cas.logout`, `cas.proxy_helper`, `cas.redirector`,
`cas.route_enhancer`, plus event subscribers (`cas.forced_auth_subscriber`,
`cas.gateway_subscriber`, `cas.auto_assign_roles_subscriber`, etc.).
