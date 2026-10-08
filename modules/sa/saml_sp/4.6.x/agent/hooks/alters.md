<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# saml_sp alter hooks

Declared in `saml_sp.api.inc`. Implement in `MODULE.module`.

## `hook_saml_sp_settings_alter(array &$settings)`

Alter the OneLogin settings array just before a SAML request/metadata is generated (and
**before** the SP private key is injected). Useful to tweak behavior per IdP.

```php
function mymodule_saml_sp_settings_alter(array &$settings) {
  // Disable strict processing for one particular IdP.
  if ($settings['idp']['entityId'] == 'http://example.com/saml/foo') {
    $settings['strict'] = FALSE;
  }
}
```

`$settings` has the OneLogin shape: `sp` (entityId, assertionConsumerService, x509cert, ...),
`idp` (entityId, singleSignOnService, x509cert, AuthnContextClassRef), `security` (all the signing
flags), `strict`, `debug`, `contactPerson`, `organization`.

## `hook_saml_sp_authn_context_class_refs_alter(array &$class_refs)`

Add or change the selectable authentication context class references (shown on the IdP form and
sent in the AuthnRequest).

```php
function mymodule_saml_sp_authn_context_class_refs_alter(array &$class_refs) {
  $class_refs['unspecified'] = [
    'value' => 'urn:oasis:names:tc:SAML:2.0:ac:classes:unspecified',
    'label' => t('Unspecified'),
  ];
}
```

Each entry: key = machine name stored in the IdP's `authn_context_class_ref`; `value` = the SAML
authn-context URN; `label` = shown in the config form. Built-in keys:
`user_name_and_password`, `password_protected_transport`, `tls_client`, `x509_certificate`,
`integrated_windows_authentication`, `kerberos`.

## Submodule hook

`saml_sp_drupal_login` adds `hook_saml_sp_drupal_login_user_attributes(UserInterface $user, array $attributes)`
to process IdP attributes onto the logged-in user (save `$user` yourself). See that submodule's docs.
