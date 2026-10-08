<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Loqate integrates the [Loqate](https://www.loqate.com/) (formerly PCA/Addressy) address-capture API with Drupal, providing a `pca_address` form element (and, via submodules, an Address-field widget and Webform elements) that gives users type-ahead address search and auto-population.

---

The base module ships a `pca_address` render element (`LoqatePcaAddress`) plus two config forms and stores the Loqate API key through the **Key** module. The address autocomplete runs **entirely client-side**: `js/pca-address.js` loads Loqate's hosted SDK from the fixed host `https://api.addressy.com/js/address-4.01.min.js` (declared in `loqate.libraries.yml`) and the resolved API key value plus a field-mapping specification are handed to it through `drupalSettings`. There is **no Drupal-side lookup route or proxy** — the browser talks to Loqate directly, so the key must be a Loqate key restricted appropriately on your account. Configure the default key at `/admin/config/services/loqate-api` (route `loqate.loqate_api_key_config_form`, permission `administer loqate api`) by choosing a Key entity; a second form at `…/pca-address` maps Loqate result fields (Line1, City, PostalCode, …) to address element keys with per-field modes (NONE/SEARCH/POPULATE/DEFAULT/PRESERVE/COUNTRY) and weights, stored in `loqate.settings:pca_fields`. Per-widget/element you may override the key by selecting a different Key entity; if empty or unresolvable, the default key is used. The `PcaAddressElementTrait` builds the lookup textfield, a hidden address-fields wrapper, a manual-input toggle, and exposes the mapping/options/key to `drupalSettings.pca_address`. Submodule **pca_address** adds a `pca_address_advanced` Address-module field widget and element; submodule **pca_webform** adds a (deprecated) `webform_address_loqate` composite Webform element. All config-form routes are gated by the single `administer loqate api` permission.

---

- Add type-ahead address search to a custom form via the `pca_address` element.
- Auto-populate address-line, city, postal-code and country fields from a Loqate result.
- Store the Loqate API key securely as a Key entity instead of raw config.
- Configure a site-wide default Loqate key at Configuration → Web services → Loqate API.
- Map Loqate response fields to address element keys with the field-mapping table.
- Choose a population mode per field (SEARCH, POPULATE, DEFAULT, PRESERVE, COUNTRY, NONE).
- Reorder field mappings by weight via drag-and-drop.
- Override the API key per field widget or per Webform element with a different Key entity.
- Restrict the address search to specific countries via `#pca_options` (`codesList`).
- Offer a "click here to enter your address manually" fallback link.
- Show address fields up-front, or keep them hidden until a result is picked.
- Add Loqate autocomplete to an Address-module `address` field (pca_address submodule widget).
- Collect verified addresses in a Webform (pca_webform composite element).
- Self-host or CSP-allow the fixed `api.addressy.com` SDK host for the client-side lookup.
- Reduce address entry errors and improve checkout/registration data quality.
- Provide consistent postal formatting across content and Webform submissions.
- Pass extra Loqate SDK options (e.g. `setCountryByIP`) through `#pca_options`.
- Read the current API key value programmatically with `Loqate::getApiKey()`.
- Reuse the `PcaAddressElementTrait` to build a custom address element.
- Migrate from an old raw-string key to a Key config entity (handled by update hooks).
