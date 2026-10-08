Commerce Checkout provides configurable, multi-step checkout flows built from reusable panes (login, address, review, payment, completion), turning a cart into a placed order.

---

Checkout is modeled as a **checkout flow** config entity composed of ordered **steps**, each containing **checkout panes**. Both flows and panes are plugin types: `commerce_checkout.checkout_flow` defines the step structure and overall behavior, while `commerce_checkout.checkout_pane` supplies each piece of the form (contact info, billing address, order summary, payment, completion message, etc.). Site builders configure which panes appear on which steps, their settings and order, through the flow's admin UI. Different order types can use different flows (e.g. a fast digital-goods flow vs. a full physical-goods flow with shipping). It supports guest checkout and login/registration, and a `CheckoutOrderManager` decides the flow and current step for an order while guarding access. It depends on Commerce, Order and Cart. Manage flows at Admin → Commerce → Configuration → Checkout flows (`entity.commerce_checkout_flow.collection`). Developers add custom panes (gift message, delivery date, terms acceptance) by implementing the checkout pane plugin.

---

- Turn a cart into a placed order through a guided checkout.
- Configure a multi-step checkout (login → order info → review → payment → complete).
- Enable guest checkout without forcing registration.
- Offer login or account creation during checkout.
- Collect billing (and shipping) addresses via panes.
- Show an order summary/review pane before payment.
- Add a payment pane that integrates the payment gateways.
- Display a completion message and next steps after ordering.
- Use different checkout flows for different order types.
- Reorder or hide panes per step in the flow UI.
- Configure per-pane settings (labels, required fields).
- Add a custom pane for a gift message or PO number.
- Add a terms-and-conditions acceptance pane.
- Capture a requested delivery date at checkout.
- Restrict checkout access based on cart/order state.
- Build a single-page vs. multi-page checkout via flow choice.
- Redirect to an off-site payment provider from a checkout pane.
- Resume an interrupted checkout at the correct step.
- Send a confirmation email on checkout completion.
- Customize the review pane's rendered summary.
- Provide a streamlined express checkout flow for digital goods.
