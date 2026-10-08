<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Accepts payments through Tap Payments' hosted checkout as a general-purpose payment-gateway service any module can call — not a Commerce-only add-on — with a signed webhook as the authoritative source of truth and no card data ever touching the site.

---

A calling module hands `tap_payment.payment` (`TapPaymentInterface::createPayment()`) a `PaymentRequest` (a `Money` amount as a decimal string, a `Customer`, a return URL and a `contextModule`/`contextId`). The service creates a Tap charge via the API client, records it in a local `tap_payment_transaction` ledger entity, and returns a `PaymentSession` whose `redirectUrl()` sends the payer to Tap's hosted page. The browser return is never believed: the return controller re-reads the charge from Tap. Tap confirms the real outcome by posting a signed webhook to `/tap-payment/webhook`; `WebhookProcessor` verifies the `hashstring` HMAC signature *before* any field is trusted, then advances the ledger through a one-way state machine and dispatches events (`PAYMENT_CREATED/CAPTURED/FAILED/CANCELLED`, `WEBHOOK_RECEIVED/VERIFIED`) that other modules subscribe to.

The design is deliberately hardened and was reviewed sound: the webhook route is `_access: 'TRUE'` **by necessity** (Tap posts serverside with no session or token) but authenticated by the signature, flood-limited (`webhook_flood_limit`) and freshness-bounded; the return route is anonymous but addressed by an unguessable UUID, flood-limited, and reveals nothing. Duplicate charges are prevented by a DB-unique idempotency key (also sent to Tap as `reference.idempotent`) and a unique `charge_id`; out-of-order/replayed deliveries are no-ops via the state machine. Secret keys are write-only in the settings form, never rendered back, and a `LogSanitizer` strips keys/tokens/cards/emails from logs. Environment (sandbox/production) is chosen purely by which secret key is configured. A future Tap API version is a single adapter class (`tap_payment_api_adapter`). Optional submodules provide Commerce and Webform integrations on the same public service. HTTP calls run with bounded timeouts and retry only idempotent/throttled failures — TLS verification is left at Guzzle's secure default.

---
- Take a one-off payment from a custom module via `tap_payment.payment`
- Create a Tap hosted-checkout charge and redirect the payer to it
- Record every attempted payment in the `tap_payment_transaction` ledger
- Confirm payment authoritatively from Tap's signed webhook, not the browser
- Verify a payment on return by re-reading the charge from Tap
- Subscribe to `PAYMENT_CAPTURED` to fulfil an order once money is taken
- React to `PAYMENT_FAILED` / `PAYMENT_CANCELLED` in your own module
- Prevent duplicate charges with a DB-unique idempotency key
- Look up a transaction by charge id, idempotency key or (module, context)
- Configure the secret key and environment at the settings form
- Keep keys out of exported config by setting them in `settings.php`
- Review the payment ledger at the transactions admin list
- Restrict who can configure or view payments via permissions
- Support asynchronous methods (e.g. Fawry) with a generous freshness window
- Reconcile abandoned/quiet checkouts on cron via the reconciler queue
- Add a new Tap API version by tagging one adapter class
- Drive Drupal Commerce checkout through the Commerce submodule
- Collect a Webform-based payment through the Webform submodule
- Flood-limit webhook and return endpoints against abuse
- Keep secrets out of logs with the built-in log sanitizer
- Emit a status-report/requirements warning when keys are missing
- Handle multi-currency amounts with correct per-currency decimal places
