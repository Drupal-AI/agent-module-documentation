<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Order Withdrawal provides a customer-facing order-withdrawal form with confirmation email and order log.

---

Commerce Order Withdrawal **provides a customer-facing order-withdrawal form** — an
implementation of the EU "droit de rétractation" (right of withdrawal, Article 11a) so a
customer can request to withdraw a placed order, receiving a confirmation email and having
the request recorded in the order log. It depends on Commerce Order and Commerce Log, and
provides its own permission.

Use it to let customers exercise a legal withdrawal right. There are two entry points. The
public form at `/order_withdrawal` is gated by the `access commerce order withdrawal form`
permission and verifies the request against **that specific order** — the submitted order
number and email must both match the order before anything is recorded, and the error
message is generic so the form never reveals whether an order number exists. The
account-scoped form at `/user/{user}/order_withdrawal/{commerce_order}` is limited to the
order's own owner (or staff with `administer commerce_order`), so a customer only ever sees
and confirms their own orders. Withdrawal is **opt-in per order type** and gated by
eligibility rules (order state, a 14-day window, and a not-already-withdrawn check). By
design the module **records and notifies rather than auto-refunding** — it stamps the order,
logs the request, and emails an acknowledgement, leaving any cancellation or refund to staff
review or to a custom event subscriber, so a request never moves money on its own.

---

- Provide a customer-facing withdrawal form (public + account-scoped).
- Implement the EU droit de rétractation (Article 11a).
- Send a confirmation email + write an order log entry.
- Depend on Commerce Order + Commerce Log.
- Provide its own permission (`access commerce order withdrawal form`).
- Serve legal compliance.
- Verify the request against that specific order (order number + matching email on the public form).
- Scope the per-user form to the order's own owner (or an order administrator).
- Gate withdrawal by a per-order-type opt-in and eligibility rules (state, 14-day window, already-withdrawn).
- Record and notify rather than auto-refund; cancellation/refund is left to staff or an event subscriber.
- Stamp a `withdrawn` timestamp on the order.
- Configure the confirmation subject and BCC per order type; override the email body via a Twig template.
- Expose a withdrawal link as a Views field and an order-display pseudo-field.
- Dispatch developer events for request, eligibility, and window start.
