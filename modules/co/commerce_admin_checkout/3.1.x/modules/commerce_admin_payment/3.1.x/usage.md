Submodule of Commerce: Admin Checkout that lets administrators stage manual "admin payments" against an order during checkout — recording real-world payments or applying payments that work like discounts — built on Commerce Multiple Payments and gated by the "apply admin payments in checkout" permission.

---

Commerce: Admin Payment extends Commerce: Admin Checkout with an "admin manual" payment gateway, a matching payment type, and an "Admin: Apply Manual Payments" checkout pane. When an administrator is running the checkout on a customer's behalf, the pane lets them choose an Admin-Manual gateway, enter an amount and a description, and stage a payment on the order. Staged payments are held on the order's `staged_multi_payment` field (via the Commerce Multiple Payments module) and are converted into real Commerce payment entities when checkout completes; if the gateway is set to "automatically received", they are marked completed without any external processor. Because these payments record money — or reduce the balance due, effectively acting like a discount — the capability is restricted: the pane only appears for users holding the `apply admin payments in checkout` permission (and only when a suitable Admin-Manual gateway applies to the order). The gateway supports the standard manual-payment operations (receive, void, refund, capture), optional negative amounts, and configurable payment instructions, and a supplied condition plugin lets you scope a gateway to the admin-payments pane, other checkout panes, or the admin "Add payment" form.

---

- Let an administrator record a manual payment against an order during assisted checkout.
- Apply a payment that reduces the customer's balance, similar to a discount (e.g. an employee discount).
- Stage multiple payments on one order before completing checkout, via Commerce Multiple Payments.
- Restrict who can apply admin payments with the `apply admin payments in checkout` permission.
- Only show the pane when an Admin-Manual gateway actually applies to the order.
- Define an "Admin Manual" payment gateway with custom payment instructions.
- Automatically mark admin payments as received, or require a manual receive step.
- Allow negative-value payments when configured (e.g. corrections/adjustments).
- Attach an administrator description/comment to each recorded payment.
- Support the standard manual-payment lifecycle: receive, void, refund, capture.
- Convert staged payments into real Commerce payment entities on checkout completion.
- Scope a gateway by context (admin-payments pane / other panes / admin add-payment form) with the supplied condition.
- Account for real-world payments (cash, cheque, bank transfer) taken outside the online store.
- Give finance/support staff a way to settle order balances from the admin side.
- Reuse your existing checkout flow rather than a separate admin payment screen.
- Combine with the parent module's order-assign and order-items panes for full assisted ordering.
- Keep payment application out of reach of ordinary customers by permission-gating the pane.
- Record employee or partner discounts as tracked payments rather than opaque price edits.
- Configure a display label and wrapper element for the checkout pane.
- Let developers react to gateway filtering through the standard Commerce FILTER_PAYMENT_GATEWAYS event.
