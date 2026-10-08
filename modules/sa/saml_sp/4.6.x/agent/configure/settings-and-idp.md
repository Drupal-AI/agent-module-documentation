<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure saml_sp: SP settings, IdPs, endpoints

Admin: `/admin/config/people/saml_sp` (route `saml_sp.admin`, form `SamlSpConfig`), permission
`configure saml sp`. IdP list: `/admin/config/people/saml_sp/idp_collection`.

## Endpoints (fixed routes)

| Route | Path | Purpose |
|---|---|---|
| `saml_sp.consume` | `/saml/consume` | Assertion Consumer Service (ACS) — IdP POSTs the response here |
| `saml_sp.metadata` | `/saml/metadata.xml` | SP metadata XML (public) |
| `saml_sp.logout` | `/saml/logout` | SAML logout callback |

## SP settings (`saml_sp.settings` config object)

```yaml
contact:
  technical: { name: '', email: '' }
  support:   { name: '', email: '' }
organization: { name: '', display_name: '', url: '' }
security:
  authnRequestsSigned: true
  logoutRequestSigned: true
  logoutResponseSigned: true
  wantMessagesSigned: true
  wantAssertionsSigned: true
  nameIdEncrypted: false
  wantNameIdEncrypted: false
  signMetaData: true
  signatureAlgorithm: 'http://www.w3.org/2001/04/xmldsig-more#rsa-sha256'
  lowercaseUrlencoding: false
entity_id: ''            # the SP entityID presented to the IdP (defaults to /user URL if empty)
cert_location: ''        # server path to SP X.509 certificate file (PHP-readable)
key_location: ''         # server path to SP private key file (PHP-readable)
new_cert_location: ''    # optional: staged next cert, advertised in metadata for rotation
strict: true             # strict SAML 2.0 processing
valid_until: ''          # metadata expiry (date/time string, or '<certificate>')
debug: false
```

Read/write with drush:

```bash
drush cget saml_sp.settings
drush cset saml_sp.settings entity_id 'urn:mysite:sp' -y
drush cset saml_sp.settings cert_location '/etc/saml/sp.crt' -y
drush cset saml_sp.settings key_location '/etc/saml/sp.key' -y
```

The private key at `key_location` is injected into settings **after**
`hook_saml_sp_settings_alter()` runs, so alter hooks never see it.

## Identity Providers (`idp` config entities)

Config name `saml_sp.idp.<id>`. Config entity type id `idp` (config_prefix `idp`). Exported keys:
`id`, `label`, `entity_id`, `app_name`, `nameid_field`, `login_url`, `logout_url`, `x509_cert`
(a sequence — first cert is used), `authn_context_class_ref` (a sequence of authn-context keys).

Create via the UI (*Add Identity Provider*; you can paste the IdP's XML metadata to auto-fill),
or programmatically:

```php
use Drupal\saml_sp\Entity\Idp;
Idp::create([
  'id' => 'my_idp',
  'label' => 'My IdP',
  'entity_id' => 'https://idp.example.com/entity',
  'login_url' => 'https://idp.example.com/sso/login',
  'logout_url' => 'https://idp.example.com/sso/logout',
  'x509_cert' => ['MIID...single-cert...'],
  'nameid_field' => 'mail',
  'authn_context_class_ref' => [],
])->save();
```

Load them with `Idp::load($id)`, `Idp::loadMultiple()`, or the helpers
`saml_sp_idp_load($id)` / `saml_sp__load_all_idps()`.

## Authn context class refs

The available authn-context keys (used in `authn_context_class_ref`) come from
`saml_sp_get_authn_context_class_refs()`: `user_name_and_password`, `password_protected_transport`,
`tls_client`, `x509_certificate`, `integrated_windows_authentication`, `kerberos` (extend via the
alter hook — see hooks/alters.md).
