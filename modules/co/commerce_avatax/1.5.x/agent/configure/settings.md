<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Commerce AvaTax

Config UI: `/admin/commerce/config/avatax` (route `commerce_avatax.config_settings`,
`ConfigSettingsForm`), permission **`administer commerce_avatax`** (restricted). Config
object: **`commerce_avatax.settings`**.

## Settings keys (`commerce_avatax.settings`)

| Key | Default | Meaning |
|---|---|---|
| `api_mode` | `development` | `production` → `rest.avatax.com`; anything else → `sandbox-rest.avatax.com`. Form labels it Development/Production. |
| `account_id` | `''` | Avalara account ID (HTTP Basic username). |
| `license_key` | `''` | Avalara license key (HTTP Basic password). |
| `company_code` | `DEFAULT` | Default company code; overridden per store by the `avatax_company_code` field. |
| `customer_code_field` | `mail` | Which order field supplies `customerCode` for authenticated users when no `avatax_customer_code` is set: `mail` or `uid`. |
| `address_validation.enable` | `false` | Validate shipping addresses on the checkout form. |
| `address_validation.enable_admin_shipment_form` | `false` | Validate on the admin shipment form (needs commerce_shipping). |
| `address_validation.countries` | `[]` | Countries where validation applies. |
| `address_validation.postal_code_match` | `false` | Require full postal-code match (else a 5-digit prefix match suppresses the suggestion). |
| `disable_commit` | `false` | Don't commit documents (calculation only, no SalesInvoice on placement). |
| `disable_tax_calculation` | `false` | Turn off tax calculation entirely. |
| `shipping_tax_code` | `FR020100` | Tax code for shipment lines (field shown only with commerce_shipping). |
| `logging` | `false` | Log full request headers/body + response to the `commerce_avatax` channel. |

## Credential validation

`ConfigSettingsForm::validateForm()` (also wired as the AJAX validate for the credential
fields) builds a client from the entered values and calls `GET /api/v2/utilities/ping`. If
`authenticated === TRUE` it then fetches `GET /api/v2/companies` and errors unless the entered
`company_code` appears in the returned `companyCode` list. So saving valid credentials also
confirms the company code exists.

## The tax type

`config/install/commerce_tax.commerce_tax_type.avatax.yml` installs a Commerce tax type with
`id: avatax`, `plugin: avatax` (`Plugin/Commerce/TaxType/Avatax`, extends
`RemoteTaxTypeBase`), `configuration.display_inclusive: false`. This is what makes tax get
calculated remotely on order refresh. There is normally only one AvaTax tax type.

## Base fields added by the module

- **commerce_store** `avatax_company_code` (string) — per-store company code override.
- **commerce_product_variation** `avatax_tax_code` (string) — Avalara tax code for the product
  (drives the default tax-code resolver).
- **user** `avatax_customer_code` (string, max 50), `avatax_tax_exemption_number` (string),
  `avatax_tax_exemption_type` (list_string, allowed values from `Avatax::getExemptionTypes()`).
  The exemption + customer-code fields are edit-gated by `configure avatax exemptions`
  (see permissions doc).

## Notes

- Credentials are stored in `commerce_avatax.settings` config (standard Drupal config; can be
  overridden per environment via `settings.php` `$config[...]` or env vars).
- With `logging` on, request **headers include the base64 HTTP Basic Authorization value** —
  it is written to the log (dblog/syslog). Leave logging off in production or restrict who can
  view logs; this is an admin-only toggle, off by default.
