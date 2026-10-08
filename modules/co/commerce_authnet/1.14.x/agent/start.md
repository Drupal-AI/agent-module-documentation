# Commerce Authorize.net — agent index

Commerce payment gateway plugins for Authorize.Net. Each gateway is a
`commerce_payment_gateway` config entity holding the API credentials + mode. No `configure`
route, no permissions, no Drush. Depends on `commerce_payment` + `commerce_checkout` and the
`commerceguys/authnet` library. Live charges need a real Authorize.Net account — so ground
work in the **gateway config entity**, not live transactions.

- **The gateway plugins, their config keys, test/live mode, the Accept.js workflow, and how
  to create/configure a gateway config entity** → [configure/payment-gateway.md](configure/payment-gateway.md)
- **The dispatched events for altering transaction requests / hosted-payment / payment
  profiles** → [api/events.md](api/events.md)

Key facts:
- Gateway plugin ids: `authorizenet_acceptjs` (primary, on-site cards), `authorizenet_accept_hosted`
  (off-site iframe), `authorizenet_echeck` (ACH), `authorizenet_visa_checkout` (legacy/deprecated).
- Shared config keys: `api_login`, `transaction_key`, `client_key`, plus Commerce `mode` = `test` | `live`.
- Config entity type: `commerce_payment_gateway`; add gateways at `/admin/commerce/config/payment-gateways`.
- Accept.js workflow: `payment_acceptjs` (`commerce_authnet.workflows.yml`).
