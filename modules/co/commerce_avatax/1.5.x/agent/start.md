<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce AvaTax — agent index

Adds an `avatax` remote Commerce tax type that calculates sales tax via Avalara's REST v2
API, commits/voids transactions on order workflow events, validates addresses, and handles
tax exemptions. Depends on Commerce (order, store, tax). Config UI at
`/admin/commerce/config/avatax` (route `commerce_avatax.config_settings`).

- **Settings keys, the config form + credential test, the `avatax` tax type, base fields,
  address validation options, per-store company code** → [configure/settings.md](configure/settings.md)
- **Services & programmatic API (`AvataxLib`), tax-code resolver chain, the two alter hooks,
  the `CUSTOMER_PROFILE` event, the address-validator route/controller** →
  [api/integration.md](api/integration.md)
- **The two permissions and the field-access rule they gate** →
  [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Config object: `commerce_avatax.settings` (schema provided). Tax type plugin id `avatax`
  (`RemoteTaxTypeBase`), installed as tax type `avatax` by `config/install`.
- All HTTP via `ClientFactory` — base URI is **fixed** to `rest.avatax.com` (production) or
  `sandbox-rest.avatax.com` (default `api_mode: development`); HTTP Basic auth from stored
  `account_id` + `license_key`. No SSRF: the host is not user/config-derived.
- Order events: place → commit `SalesInvoice`; cancel/delete → void (`OrderSubscriber`).
- Base fields: store `avatax_company_code`, product-variation `avatax_tax_code`, user
  `avatax_customer_code` / `avatax_tax_exemption_number` / `avatax_tax_exemption_type`.
- No Drush, no plugin *types* (tax-code resolvers are tagged services, not a plugin manager).
