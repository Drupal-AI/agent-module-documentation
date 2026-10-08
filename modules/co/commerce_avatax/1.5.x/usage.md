<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Integrates Drupal Commerce with Avalara AvaTax for real-time sales-tax calculation, transaction committing/voiding, address validation, and tax exemptions.

---

Commerce AvaTax adds an `avatax` remote tax type (`RemoteTaxTypeBase`) that, during order refresh, sends each order's line items and ship-from/ship-to addresses to Avalara's REST v2 API and applies the returned tax as commerce adjustments. Global settings live in `commerce_avatax.settings` (account ID, license key, API mode development/sandbox vs production, company code, address-validation options, shipping tax code, logging) edited at `/admin/commerce/config/avatax`; the settings form validates credentials by pinging `api/v2/utilities/ping` and confirming the company code against `api/v2/companies`. All HTTP goes through `ClientFactory`, which hard-codes the base URI to `https://rest.avatax.com/` (production) or `https://sandbox-rest.avatax.com/` (default) and sends HTTP Basic auth built from the stored account ID + license key. An `OrderSubscriber` commits a `SalesInvoice` transaction on order placement and voids it on cancel/delete. Per-order-item tax codes are resolved through a tagged `commerce_avatax.tax_code_resolver` chain (default: the product variation's `avatax_tax_code` base field). The module adds base fields for a store `avatax_company_code`, product-variation `avatax_tax_code`, and user `avatax_customer_code` / tax-exemption number+type (the exemption fields editable only with the `configure avatax exemptions` permission). A JSON endpoint (`/commerce-avatax/address-validator`, CSRF-protected) plus a customer-profile inline-form alter offer AvaTax address suggestions at checkout. Two alter hooks and the Commerce `CUSTOMER_PROFILE` event let other code adjust the request/response and profile.

---

- Calculate US (and other) sales tax on Commerce orders in real time via Avalara AvaTax.
- Run against the AvaTax sandbox during development, then switch to production.
- Commit a finalized transaction to AvaTax automatically when an order is placed.
- Void the AvaTax transaction automatically when an order is cancelled or deleted.
- Skip document committing (report-only) by enabling "Disable document committing".
- Temporarily turn off tax calculation without uninstalling via "Disable tax calculation".
- Validate and correct a customer's shipping address at checkout with AvaTax suggestions.
- Validate shipping addresses on the admin shipment form (with commerce_shipping).
- Restrict address validation to specific countries.
- Enforce strict full-postal-code matching on validated addresses.
- Assign a specific Avalara tax code per product variation (`avatax_tax_code` field).
- Set a dedicated shipping tax code (default `FR020100`) for shipment lines.
- Use a per-store company code, falling back to the global company code.
- Send a customer's tax-exemption number and usage/entity-use type to AvaTax.
- Restrict who can edit exemption fields via the `configure avatax exemptions` permission.
- Choose whether the AvaTax customerCode is derived from the order email or user ID.
- Set an explicit AvaTax customer code per user (`avatax_customer_code`).
- Add a custom tax-code resolver plugin (tagged service) for bespoke tax-code logic.
- Alter the outbound transaction request body via `hook_commerce_avatax_order_request_alter()`.
- React to the AvaTax response via `hook_commerce_avatax_order_response_alter()`.
- Enable detailed request/response logging to debug AvaTax API calls.
- Cache repeat transaction and address-resolve calls (24h) to cut API usage.
- Confirm credentials and company code are valid straight from the settings form.
- Power a custom AJAX address-validation UI against the module's JSON endpoint.
- Support tax exemptions for B2B/wholesale customers.
