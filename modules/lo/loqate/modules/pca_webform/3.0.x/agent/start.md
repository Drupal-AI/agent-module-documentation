<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# PCA Webform (Loqate submodule) — agent index

Provides a **deprecated** composite Webform element `webform_address_loqate` for Loqate-verified
addresses. Depends on `loqate` + `webform`. No config UI, no permissions, no Drush.

- **The `webform_address_loqate` element: subfields, JS/key wiring, deprecation** →
  [plugins/element.md](plugins/element.md)

Key facts:
- Element id **`webform_address_loqate`** (category "Composite elements"), `@deprecated` since Loqate
  2.1.0 — prefer the base `pca_address` element on new forms.
- Subfields: address, address_2, city, region, state_province (select), postal_code, country (select).
- Renders → attaches `pca_webform/element.pca_webform.address.js` (which depends on the base module's
  external `api.addressy.com` SDK) and exposes `Loqate::getApiKey()` at
  `drupalSettings.loqate.loqate.key`. Client-side lookup only.
- `hook_webform_options_alter` sets a `data-option-type` attribute when a named options set is used.
