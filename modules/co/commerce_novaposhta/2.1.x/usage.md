<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Novaposhta adds Nova Poshta, Ukraine's main parcel carrier, as a Commerce Shipping method. It provides a custom checkout field for choosing a settlement/city and a Nova Poshta warehouse (branch), and calculates delivery cost by calling the Nova Poshta API. Use it for Ukrainian stores that ship to Nova Poshta pickup points.

---

Install with Composer (`drupal/commerce_novaposhta`), enable it (depends on commerce_shipping), and enter your Nova Poshta API key at /admin/config/services/commerce-novaposhta (route commerce_novaposhta.novaposhta_config_form, gated by the restricted 'administer commerce novaposhta configuration' permission). Add a Nova Poshta shipping method to a shipping method entity. The API key is stored in module config; API calls use Guzzle over HTTPS with default certificate verification. Add the Novaposhta field to your checkout to let customers pick a branch.

---

- Add Nova Poshta as a Commerce shipping method.
- Calculate delivery price via the Nova Poshta API.
- Let customers select a settlement/city at checkout.
- Let customers pick a Nova Poshta warehouse/branch.
- Provide a custom Novaposhta field type, widget and formatter.
- Cache and search cities, areas and warehouses.
- Configure the API key on an admin form.
- Gate configuration behind a restricted permission.
- Support multiple shipping method entities.
- Call the API over HTTPS with TLS verification.
- Alter request/result data via hook_alter hooks.
- Store address/branch data on the order.
- Integrate with commerce_shipping rate flows.
- Restrict the config route to trusted admins.
- Keep the Nova Poshta API key confidential.
- Provide install/update hooks for schema.
