<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Pricing & Stripe payment

## Pricing engine (`src/Pricing/`)
Prices are computed by a pluggable engine driven by `PricingService`
(`Drupal\conreg\Service\PricingServiceInterface`). Two attribute-based plugin types, each with its
own manager (`parent: default_plugin_manager`):

- **`MemberPricingRule`** (`#[MemberPricingRule]`, `MemberPricingRuleInterface::priceMember()`
  returns a `MemberPriceContribution`). Shipped: `BaseTypePricingRule` (base membership-type price),
  `AddonPricingRule` (add-on charges).
- **`PricingAdjustment`** (`#[PricingAdjustment]`, `adjust(array $memberResults, PricingContext)`).
  Shipped: `NthMemberFreeAdjustment` (every Nth group member free, via the event's
  `discount.free_every` setting).

Supporting value objects: `PricingContext`, `PricingSubject`, `PricingResult`,
`MemberPriceResult`, `PriceLine`, `PriceAdjustment`, `AddOnSelection`, `PricingRecomputeResult`.
The `conreg_price_availability` block (`PriceAvailabilityBlock`) surfaces current prices/availability.

## Payment tables & flow
Tables (`conreg.install`): `conreg_payments` (payid, `random_key`, dates, method, amount, ref),
`conreg_payment_lines` (per-member line: type `member`/`upgrade`, description, amount),
`conreg_payment_sessions` (maps `payid` → Stripe `session_id`). `Payment`/`PaymentLine` wrap the
rows; `PaymentStorage` persists them. `PaymentStorage::checkPaymentKey($payid, $key)` binds a
checkout URL to its payment via `payid` + `random_key`.

`Form\Checkout` (`members/checkout/{payid}/{key}`, perm `convention registration`; variants for
fantable/checkin/portal returns):
1. Validates `payid`+`key` via `checkPaymentKey`; loads the payment and its event.
2. `PricingService::recomputeForPayment()` recomputes line amounts from current member/config data
   (so an admin edit between registration and payment is reflected before charging).
3. Builds Stripe line items **server-side** from the payment lines (`unit_amount = amount * 100`,
   currency from `payments.currency`) and creates a **Stripe Checkout Session**
   (`StripeService::createCheckoutSession`), saving `session.id` onto the payment. The browser is
   handed off to Stripe via the `conreg/conreg_checkout` library (Stripe.js + public key).
4. Zero-total payments are marked paid as method `Free` without contacting Stripe.

## Completion (reconcile from Stripe Events)
On return, `Checkout::processStripeMessages()` calls `StripeService::getEvents('checkout.session.completed',
now-24h)` and, for each event, loads the local payment by `session.id`. If the payment is not yet
paid it records `paidDate`, `paymentMethod = 'Stripe'` and `paymentRef = payment_intent`, then
processes each line: `member` lines set `is_paid` (and, if `payments.auto_approve`, assign the next
`member_no` and approve), send the Easy Email confirmation via `RegistrationConfirmationMailer`, and
grant any configured portal role; `upgrade` lines complete via `UpgradeManager`. This is a
pull/reconcile model against the Stripe Events API — there is no inbound webhook route.

## Stripe keys (Key module)
`StripeService` (`src/Service/StripeService.php`) takes the per-event `payments.private_key` and
`payments.public_key` config values as **Key entity IDs** and resolves them through `key.repository`
(`resolveKey()`), so the actual Stripe secrets live in Key entities, not in ConReg config. `key:key`
is a required dependency. `verifyKeys()` performs a live `balance->retrieve()` to validate the
secret key and checks that both keys share the same test/live mode; the Event Config form surfaces
the result. `payments.types` selects the Stripe payment method types (default `card`).
