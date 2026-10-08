<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Routes, forms, access & eligibility

## Routes (`commerce_order_withdrawal.routing.yml`)

### `commerce_order_withdrawal.form` — `/order_withdrawal`
Public form `OrderWithdrawalForm`, `_permission: 'access commerce order withdrawal form'`.
Two required fields: `order_number` (textfield) and `order_email` (email). Per Article 11a
these are the only mandatory fields; the submit button *is* the withdrawal declaration.

`validateForm()`:
1. `resolveOrder()` loads the order by `order_number` (`loadByProperties`).
2. Requires `strcasecmp($order->getEmail(), $email) === 0` — both number and email must
   match. If either fails, one generic error (`We could not match that order number and
   email.`) is set — no enumeration oracle.
3. `eligibility->check($order)`; on failure the built-in reason string is shown.
4. On success stashes the order in `$form_state->set('withdrawal_order', …)`.

`submitForm()` calls `processor->process($order, $email)`, shows a status message,
redirects to `<front>`.

### `commerce_order_withdrawal.form.user` — `/user/{user}/order_withdrawal/{commerce_order}`
Form `CustomerOrderWithdrawalForm`; `_custom_access:
OrderWithdrawalController::accessUserForm`. Both params are upcast entities.

**Access (`accessUserForm`)** — allowed only when:
- `commerce_order->getCustomerId() === user->id()` (order belongs to the routed user), AND
- current account is that same user (authenticated) OR has `administer commerce_order`.

Anonymous is denied. Result carries order + user cache deps, `cachePerUser`,
`cachePerPermissions`. Covered by `OrderWithdrawalUserAccessTest`.

**Form** — ownership already enforced by the route, so it neither collects nor verifies an
email. `buildForm()` re-checks eligibility; if ineligible it renders the notice from
`WithdrawalNoticeTrait::buildIneligibleNotice()` (a warning `status_messages` + a link to
the generic form) instead of the confirm button. The specific reason is safe to show here
(viewer is owner/admin). On confirm, `submitForm()` **re-checks eligibility defensively**
(order may have changed since render), uses `$order->getEmail()` as the request email, calls
`processor->process()`, and redirects to `view.commerce_user_orders.order_page`.

## Eligibility (`WithdrawalEligibility::check()` → `EligibilityResult`)
Built-in checks, in order (first failure returns a `denied` reason string):
1. **Order-type opt-in** — `commerce_order_type` third-party setting
   `commerce_order_withdrawal.enabled` must be TRUE.
2. **State** — not in `INELIGIBLE_STATES = ['draft', 'canceled']`.
3. **Within window** — see below.
4. **Not already withdrawn** — `withdrawn` base field is empty (loaded with the order, no
   extra query).
5. **Subscriber event** — dispatches `WithdrawalEvents::ELIGIBILITY`
   (`WithdrawalEligibilityEvent`); a subscriber may `deny($reason)` (deny-only, first denial
   wins). Cannot override a built-in denial (event fires only after 1–4 pass).

`EligibilityResult` is immutable: `allowed()` / `denied(string $reason)`, with
`isEligible()` and `getReason()`.

### The 14-day window
`WITHDRAWAL_WINDOW_DAYS = 14`; `getWindowSeconds()` = `14 * 86400`. `resolveWindow()` builds a
`WithdrawalWindowEvent` seeded with the order's placed time and dispatches
`WithdrawalEvents::WINDOW`. Three outcomes:
- **pending** (a subscriber called `markPending()`) → eligible, clock not started, cannot
  expire;
- **NULL start** (never placed, no subscriber start) → not eligible;
- **concrete start** → eligible while `now <= deadline`, where `deadline = start +
  getWindowSeconds()`, then extended by `WorkingDayCalendar::extendDeadline()`.

`getWindowStart()` returns the anchor or NULL (pending/never-placed collapse to NULL — use
`check()` for eligibility decisions, not this value).

### `WorkingDayCalendar` (Yasumi)
`extendDeadline(int $deadline, ?string $countryCode)`: if the country is unknown or has no
Yasumi provider, the deadline is unchanged. Otherwise, if the deadline lands on a weekend
or public holiday it rolls forward to **23:59:59 of the next working day** (site default
timezone), re-resolving the Yasumi provider across a year boundary. Billing country comes
from the order's billing profile address `country_code`.

## Processing side-effects (`WithdrawalProcessor::process($order, $email)`)
In order:
1. `stampWithdrawalTime()` — sets `withdrawn` = request time and **saves the order**.
2. `logRequest()` — `commerce_log` `generate($order, 'order_withdrawal_requested',
   ['email' => $email])->save()`. Log template renders `Withdrawal requested by <em>{{ email
   }}</em>.` on the order Activity tab.
3. `sendConfirmation()` — subject = configured `withdraw_subject` (token-replaced) or the
   default `Withdrawal confirmation — order @number`; body = `#theme
   commerce_order_withdrawal_confirmation` (order entity); sent via
   `commerce.mail_handler->sendMail($email, $subject, $body, $params)` with `store` in
   params and `bcc` added only when `withdraw_bcc` is non-empty (token-replaced).
4. Dispatches `WithdrawalEvents::REQUEST` (`WithdrawalRequestEvent`) — *after* log + email.

No cancellation, no refund, no order-state transition beyond the `withdrawn` stamp.
