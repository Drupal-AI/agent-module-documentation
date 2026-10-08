# Commerce Authorize.net (commerce_authnet) 2.0.x

Commerce payment gateway plugins for Authorize.Net. Each gateway is a
`commerce_payment_gateway` config entity holding the API credentials + mode. No `configure`
route, no permissions, no Drush. Requires **Drupal 10.3+/11 and Commerce 3** (`drupal/commerce:^3.3.9`);
Drupal 9 and Commerce 2 are no longer supported. Depends on `commerce_payment` +
`commerce_checkout` and the `commerceguys/authnet` library. Live charges need a real
Authorize.Net account — so ground work in the **gateway config entity**, not live transactions.

- **The gateway plugins, their config keys, test/live mode, the Accept.js workflow, Accept
  Hosted webhooks + stored payment methods, and how to create/configure a gateway config
  entity** → [configure/payment-gateway.md](configure/payment-gateway.md)
- **The dispatched events for altering transaction requests / hosted-payment / payment
  profiles** → [api/events.md](api/events.md)

Key facts:
- Gateway plugin ids: `authorizenet_acceptjs` (primary, on-site cards), `authorizenet_accept_hosted`
  (off-site iframe), `authorizenet_echeck` (ACH), `authorizenet_visa_checkout` (legacy/deprecated).
- Shared config keys: `api_login`, `transaction_key`, `client_key`, plus Commerce `mode` = `test` | `live`.
- Config entity type: `commerce_payment_gateway`; add gateways at `/admin/commerce/config/payment-gateways`.
- Accept.js workflow: `payment_acceptjs` (`commerce_authnet.workflows.yml`).
- Accept Hosted is an off-site gateway: `onReturn` finishes checkout, and a webhook (`onNotify`,
  on the standard `commerce_payment.notify` route) syncs authcapture/refund/void/payment-profile
  events. It also supports stored/reusable payment methods (card-on-file).
- Hooks are OOP: `src/Hook/CommerceAuthNetHooks.php` (`#[Hook]`); `.module` keeps thin
  `#[LegacyHook]` wrappers. `hook_cron` runs the eCheck settlement verifier.
