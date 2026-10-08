<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Tap Payment (tap_payment) — agent index

**A payment-gateway plugin API driving Tap Payments' hosted checkout; webhook-authoritative, no card data on site.**

- **Version:** 1.2.x · package Payment · PHP 8.3+
- **Core:** ^10.3 || ^11 || ^12
- **Configure:** `tap_payment.settings` → `/admin/config/services/tap-payment`; ledger at `/admin/config/services/tap-payment/transactions`
- **Permissions:** `administer tap payment`, `view tap payment transactions` (both restrict access)
- **Service:** `tap_payment.payment` (`TapPaymentInterface`) — `createPayment()`, `verifyPayment()`, `loadByChargeId/IdempotencyKey/Context()`
- **Routes:** `tap_payment.webhook` (`POST /tap-payment/webhook`, `_access: TRUE`, HMAC-verified, flood-limited); `tap_payment.return` (`/tap-payment/return/{uuid}`, `_access: TRUE`, UUID-addressed, flood-limited); admin routes permission-gated
- **Entity:** `tap_payment_transaction` ledger · **Plugins:** payment gateways (`tap`), API adapters (`tap_payment_api_adapter`) · **Events:** `TapPaymentEvents`

**Security:** reviewed sound. The two open routes are open *by necessity* (serverside webhook / sessionless payer return) and authenticated by an HMAC signature / unguessable UUID respectively, both flood-limited; the webhook verifies its `hashstring` signature before believing any field, then binds the charge id, amount and currency to the site's own ledger row before applying an outcome. Idempotency + unique charge id prevent duplicate charges; a one-way state machine makes replays no-ops. Secret keys are write-only and log-sanitized; TLS left at Guzzle's secure default.

## Diff 1.1.x → 1.2.x
Compatibility-only release (1.2.0, released 2026-08-17). Real changes:
- **Drupal 12 support.** `core_version_requirement` gains `^12` on the module and all three submodules (`tap_payment_custom`, `tap_payment_commerce`, `tap_payment_webform`); the Composer `drupal/core` and `drupal/core-dev` constraints become `^10.3 || ^11 || ^12`.
- **Status-report severities via `DeprecationHelper`.** `StatusReport.php` resolves each severity through `DeprecationHelper::backwardsCompatibleCall(\Drupal::VERSION, '11.2.0', …)`, so Drupal 11.2+ receives the `RequirementSeverity` enum and Drupal 10.3 keeps the `REQUIREMENT_*` constants. The procedural `hook_requirements()` (`#[LegacyRequirementsHook]`) and the OO `TapPaymentRequirements` both read the same `tap_payment.status_report` service.
- **No behavioural or public-API change.** Nothing under `src/Webhook/`, `src/Controller/` or the payment service changed; signature verification and outcome application are byte-identical to 1.1.x. Validated on Drupal 11.4.4; Drupal 12 and 10.3 established by static analysis.

See [api/service.md](api/service.md) and [configure/setup.md](configure/setup.md)
