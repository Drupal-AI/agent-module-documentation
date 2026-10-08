<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Order Withdrawal — agent index

Customer-facing **order-withdrawal form** for Drupal Commerce (the EU *right of
withdrawal* / *droit de rétractation*, Article 11a). A customer identifies a placed order,
submits, and the module **records the request on the order and emails an acknowledgement**.
It is deliberately light: it **records and notifies — it does not cancel or refund**.
Cancellation/refund is left to staff or to a downstream event subscriber.

Version **1.0.0-alpha1** (1.0.x). Core `^10.3 || ^11`. Depends on `commerce_order`,
`commerce_log`. Composer pulls in `azuyalabs/yasumi` (public-holiday calendars). One
permission, no Drush, no central settings page (configured per order type).

## Subdocs
- **Routes, forms, access, eligibility, the processing side-effects** → [routes-eligibility.md](routes-eligibility.md)
- **Developer surface: services, the three events, base field, link integration** → [developer-api.md](developer-api.md)

## Two entry points (both `FormBase`, CSRF-protected)
| Route | Path | Form | Access |
| --- | --- | --- | --- |
| `commerce_order_withdrawal.form` | `/order_withdrawal` | `OrderWithdrawalForm` | permission `access commerce order withdrawal form`; verifies **order number + matching email** |
| `commerce_order_withdrawal.form.user` | `/user/{user}/order_withdrawal/{commerce_order}` | `CustomerOrderWithdrawalForm` | `OrderWithdrawalController::accessUserForm` — the order's **owner** (routed user, and viewer is that user) or `administer commerce_order`; read-only number, one-click confirm |

Registered-customer orders are withdrawn from the account-scoped route (order's own email
and billing address are used, no re-entry). Guest orders have **no per-order route** — a
guest uses the generic public form and types the order number + email.

## Key facts
- **Opt-in per order type.** Nothing is withdrawable until the order type's third-party
  setting `commerce_order_withdrawal.enabled` is TRUE (set in the *Order withdrawal*
  section added to the order-type edit form). Also configurable per type: `withdraw_subject`
  (token-aware, falls back to a default) and `withdraw_bcc` (token-aware, omitted when empty).
- **Eligibility** (`commerce_order_withdrawal.eligibility` → `EligibilityResult`): enabled
  for the type, state ∉ `{draft, canceled}`, within the **14-day window**, not already
  withdrawn — then a deny-only subscriber event. Window start defaults to the placed time;
  the deadline rolls forward past weekends/public holidays in the order's billing country
  (`WorkingDayCalendar` via Yasumi).
- **Processing** (`commerce_order_withdrawal.processor`): stamps the `withdrawn` base field
  on the order, writes an `order_withdrawal_requested` `commerce_log` entry, sends the
  confirmation email through `commerce.mail_handler` (body = `commerce-order-withdrawal-confirmation`
  Twig template, override in theme), then dispatches `WithdrawalEvents::REQUEST`.
- **`withdrawn` base field** (timestamp) is added to every `commerce_order`; powers the
  cheap already-withdrawn check and is display/Views-usable.
- **Withdrawal link** from a single builder (`commerce_order_withdrawal.link_builder`),
  exposed as a Views field (`commerce_order_withdrawal_link`) and an order-display
  pseudo-field (`withdrawal_link`), each rendered via a `#lazy_builder` placeholder and
  **hidden for ineligible or guest orders**.

## Config / verification quick reference
- Permission: `access commerce order withdrawal form` at `/admin/people/permissions`.
- Per type: `/admin/commerce/config/order-types/{type}/edit` → *Order withdrawal*.
- Link display: order type *Manage display* (`…/edit/display`) or add the Views field.
- No `configure` route; no Drush commands.
