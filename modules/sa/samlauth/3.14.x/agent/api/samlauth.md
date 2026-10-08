# Programmatic API — `SamlService`

Service id **`samlauth.saml`**, class `Drupal\samlauth\SamlService`. It wraps the
`onelogin/php-saml` toolkit and drives login/acs/logout/metadata. The `SamlController`
(`/saml/*` routes) is a thin wrapper over it; you rarely call the flow methods yourself, but
reading attributes and metadata is useful.

```php
/** @var \Drupal\samlauth\SamlService $saml */
$saml = \Drupal::service('samlauth.saml');
```

## Useful public methods

| Method | Purpose |
|---|---|
| `getMetadata($validity = NULL, $cache_duration = NULL, bool $allow_invalid = FALSE)` | Returns the SP metadata XML string. |
| `login($return_to = NULL, array $parameters = [], $force_auth = FALSE)` | Build & send the AuthnRequest (redirect to IdP). `$force_auth` = ForceAuthn (reauth). |
| `acs()` | Process the IdP response at `/saml/acs`: validate assertion, link/create + log in the Drupal user. |
| `logout($return_to = NULL, array $parameters = [])` | Start SP-initiated Single Logout. |
| `sls()` | Process a Single Logout request/response. |
| `getAttributes()` | Returns the SAML attributes from the last validated response (single values as one-element arrays). |
| `getAttributeByConfig(string $config_key)` | Reads the attribute whose name is stored in the given config key (e.g. `user_mail_attribute`). |
| `synchronizeUserAttributes(UserInterface $account, $skip_save = FALSE, $first_saml_login = FALSE)` | Re-run the user-sync (dispatches `USER_SYNC`) for an account. |
| `setKeyRepository(KeyRepositoryInterface $key_repository)` | Injected optionally (`@?key.repository`) so the SP key/cert can come from a Key entity. |

Constructor dependencies: `externalauth.externalauth`, `externalauth.authmap`,
`config.factory`, `entity_type.manager`, the `logger.channel.samlauth` channel,
`event_dispatcher`, `request_stack`, `tempstore.private`, `flood`, `current_user`, `messenger`.

## Where the user link lives

The SAML-login ↔ Drupal-user association is stored via the **externalauth** module in the
`authmap` table under provider `samlauth`. Use externalauth's `externalauth.authmap` service to
look up / prepopulate links; samlauth itself does account create/link/sync inside `acs()`.

## Related helper classes

- `Drupal\samlauth\UserVisibleException` — exception whose message is safe to show to the user.
- `Drupal\samlauth\AuthVolatile` — holds volatile per-request auth state.

To act on attributes during login/registration, subscribe to the events rather than calling
these methods — see [../extend/samlauth.md](../extend/samlauth.md).
