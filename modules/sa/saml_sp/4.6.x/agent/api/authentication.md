<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# saml_sp programmatic API

`saml_sp` is a toolkit: it validates SAML but delegates "what to do on success" to a callback.
All functions below are procedural (defined in `saml_sp.module`).

## Start authentication

```php
saml_sp_start($idp, $callback, $forceAuthn = FALSE);
```

- `$idp` — an `Idp` config entity (e.g. `saml_sp_idp_load('my_idp')`).
- `$callback` — a function name invoked when the response comes back to `/saml/consume`. It is
  called as `$callback($is_valid, \OneLogin\Saml2\Response $response, Idp $idp)`.
- `$forceAuthn` — force IdP re-authentication even with an existing SSO session.
- Honors a `returnTo` query param; otherwise returns the user to the front page.
- Returns a `RedirectResponse` (302 to the IdP) on success, or redirects to `<front>` with an
  error logged if the SP settings cannot be built. On debug it returns the redirect URL string.

`SamlSPController::consume()` (route `saml_sp.consume`) validates the incoming response and then
invokes the tracked callback. Outbound requests are tracked in a shared tempstore via
`saml_sp__track_request($id, $idp, $callback)` / `saml_sp__get_tracked_request($id)`.

## Build settings & metadata

```php
$settings = saml_sp__get_settings($idp);   // assembles the onelogin/php-saml settings array
[$metadata, $errors] = saml_sp__get_metadata();  // SP metadata XML + validation errors
```

`saml_sp__get_settings()` merges `saml_sp.settings` with the IdP entity into the OneLogin settings
structure (sp/idp entityIds, ACS URL `/saml/consume`, security flags, contacts, organization,
cert/key from the configured file paths). It invokes `hook_saml_sp_settings_alter()` **before**
adding the private key.

## Load IdPs

```php
saml_sp_idp_load($machine_name);   // one Idp (or passes through an array)
saml_sp__load_all_idps();          // all Idp entities keyed by machine name
```

## Authn context class refs

```php
$refs = saml_sp_get_authn_context_class_refs();
// keys: user_name_and_password, password_protected_transport, tls_client,
//       x509_certificate, integrated_windows_authentication, kerberos
// each => ['value' => <SAML AC constant>, 'label' => <Translatable>]
```

Extend the list with `hook_saml_sp_authn_context_class_refs_alter()` (see hooks/alters.md).

## Notes

- The old `saml_sp__is_valid_authentication_response()` and
  `saml_sp_authn_context_class_refs()` are **deprecated** (removed in 5.0.0); use the controller
  flow and `saml_sp_get_authn_context_class_refs()` instead.
- To actually log a Drupal user in from a validated response, use the `saml_sp_drupal_login`
  submodule (it registers `saml_sp_drupal_login__saml_authenticate` as the callback).
