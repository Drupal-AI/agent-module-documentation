<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Loqate — agent index

Client-side address autocomplete/verification via Loqate's hosted SDK. Base module = a `pca_address`
form element + two admin config forms (API key, field mapping) + a `Loqate::getApiKey()` helper. The
key is stored via the **Key** module; lookups happen in the browser against the fixed host
`api.addressy.com` (no Drupal proxy route). Config route `loqate.loqate_api_key_config_form`
(`/admin/config/services/loqate-api`), permission `administer loqate api`. No Drush.

- **The two admin forms, key selection, field-mapping table, config keys, Drush setup** →
  [configure/settings.md](configure/settings.md)
- **The `pca_address` element, `#pca_fields`/`#pca_options`, drupalSettings wiring, `Loqate::getApiKey()`** →
  [api/element.md](api/element.md)
- **The single permission** → [permissions/permissions.md](permissions/permissions.md)

Submodules (own docs):
- `pca_address` (Address-module widget/element) →
  [../../modules/pca_address/3.0.x/agent/start.md](../../modules/pca_address/3.0.x/agent/start.md)
- `pca_webform` (deprecated Webform element) →
  [../../modules/pca_webform/3.0.x/agent/start.md](../../modules/pca_webform/3.0.x/agent/start.md)

Key facts:
- Fixed external SDK: `libraries.pca.address.js` → `https://api.addressy.com/js/address-4.01.min.js`
  (+ matching CSS). Allow it in CSP or self-host.
- The resolved **key value** (not the Key id) is emitted to `drupalSettings` for the client SDK — by
  design; use a domain-restricted Loqate key.
- Field mapping default lives in `loqate.settings:pca_fields`; the API key id in
  `loqate.loqateapikeyconfig:loqate_api_key`.
- Requires the `key` module. Optional `address` (pca_address) and `webform` (pca_webform) submodules.
