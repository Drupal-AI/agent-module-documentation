<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `webform_address_loqate` composite element (deprecated)

Source: `modules/pca_webform/src/Element/WebformAddressLoqate.php` (form element) and
`modules/pca_webform/src/Plugin/WebformElement/WebformAddressLoqate.php` (Webform element plugin).

> **Deprecated** in Loqate 2.1.0, to be removed in 3.0.0. New builds should use the base module's
> `pca_address` element (see [../../../../../3.0.x/agent/api/element.md](../../../../../3.0.x/agent/api/element.md)).

## What it is

A composite Webform element (`@WebformElement(id = "webform_address_loqate")`, category "Composite
elements", `composite = TRUE`). Add it like any Webform element (Build → Add element → "PCA address").

### Composite subfields (`getCompositeElements()`)

| Key | Type | Title |
|---|---|---|
| `address` | textfield | Address |
| `address_2` | textfield | Address 2 |
| `city` | textfield | City/Town |
| `region` | textfield | Region |
| `state_province` | select (`state_province_names`) | State/Province |
| `postal_code` | textfield | Zip/Postal Code |
| `country` | select (`country_names`) | Country |

## Client-side wiring (`preRenderWebformCompositeFormElement`)

- Adds classes `address-lookup` / `address-lookup__field` (+ `--initial` on all but postal_code) and a
  `data-key` per subfield.
- Attaches library `pca_webform/element.pca_webform.address.js` (depends on the base Loqate SDK
  library → external `api.addressy.com`).
- Exposes the resolved key value at `drupalSettings.loqate.loqate.key` via `Loqate::getApiKey()`
  (site default key; no per-element override here). Lookup is entirely client-side.

## Display formatting

The plugin's `formatTextItemValue()` / `formatHtmlItemValue()` build human-readable address lines from
the stored composite value (collapsing city + state/province + postal code into a `location` line and
resolving select option labels via `getValueFromOptions()`).
