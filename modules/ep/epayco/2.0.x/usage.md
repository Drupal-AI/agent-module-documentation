<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
ePayco provides a reusable Drupal integration for the ePayco (Colombian/Latin American) payment provider.

---

ePayco lets a Drupal site talk to the ePayco payment provider without necessarily using Drupal Commerce. The base
module stores one or more sets of ePayco account settings as configuration entities ("factories") at
`/admin/config/services/epayco/factory`, and exposes a single reusable service (`epayco.handler`,
`Drupal\epayco\GatewayHandler`) that wraps the ePayco PHP SDK and its REST endpoints — looking up a transaction by
id, looking up a payment by reference code, fetching the PSE bank list, and building the signed parameters for a
standard checkout. It also ships a `PaymentOptionsHandler` that renders standalone ePayco "payment option" buttons
(handy for donation or quick-pay pages) and a transaction-response page plus event that other modules can react to.
Drupal Commerce integration, an API-operations endpoint, and a Business Rules integration are provided as separate
submodules so you enable only what you need. Handle the ePayco account credentials as secrets and serve the site
over HTTPS.

---

- Accept ePayco payments on a Drupal site.
- Store several sets of ePayco account settings as configuration entities ("factories").
- Keep a default account set and separate per-store settings.
- Configure ePayco credentials at `/admin/config/services/epayco/factory`.
- Toggle ePayco test mode per factory.
- Use the reusable `epayco.handler` service in custom code.
- Look up a remote transaction by transaction id.
- Look up a payment by ePayco reference code (`ref_payco`).
- Fetch the list of available PSE banks by public key.
- Build a signed standard-checkout parameter set for an order.
- Render standalone ePayco payment buttons without Drupal Commerce.
- Build donation or quick-pay pages that launch ePayco checkout.
- Provide a transaction-response landing page for returning customers.
- React to the `epayco.transaction.response` event from your own module.
- Alter outbound checkout data via the provided hook before it is sent.
- Restrict who can manage ePayco factories via a dedicated permission.
- Restrict who can access the transaction-response page via a dedicated permission.
- Add Drupal Commerce gateways by enabling the `commerce_epayco` submodule.
- Run ePayco SDK operations over HTTP by enabling the `epayco_api` submodule.
- Integrate with the Business Rules module via the `epayco_business_rules` submodule.
- Support multiple ePayco merchant accounts on one site.
- Localize the ePayco flow with a per-factory language code.
