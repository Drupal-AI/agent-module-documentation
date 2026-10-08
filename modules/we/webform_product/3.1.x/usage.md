<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Webform Product attaches a single "Webform product" submission handler to a webform and turns each submission into a Drupal Commerce order: priced webform elements become order items, the items are added to the current user's cart, the order is locked, and the buyer is redirected into Commerce checkout — designed to finish through an off-site (redirect) payment gateway.

---

The paid ad-hoc form is a gap that neither Webform nor Commerce closes alone, and this module bridges it without requiring a catalogue product. Pricing lives on the webform, not on a product entity: an admin sets prices as webform third-party settings — a price per select/radio/checkbox option (choose the option, get that price as an order item), a per-element "top" price added as a flat supplement, an "Other" numeric amount that lets the submitter name their own price (the donation case), or a single "Total price" element mapped in the handler that becomes one order item. On the first (and only the first) save of a submission the handler reads those priced elements, builds `commerce_order_item` entities with a `unit_price` drawn from that configuration (currency = the store's default), clears and refills the current user's cart, saves and **locks** the order so nothing else can be added, writes the submission id into the order's data, sets the submission to `in_draft`, stamps a `payment_status` element to `initialized`, and — through a custom HTTP middleware that overrides the normal webform confirmation redirect — sends the buyer to a configured checkout step. Because the design targets off-site payment, `hook_form_alter` rewrites the gateway's return/cancel/exception URLs to three module routes (`/webform-product/{webform}/{order}/{completed,canceled,exception}`); the completed route places the order, un-drafts and completes the submission (firing the webform's other handlers, e.g. email), and shows the webform confirmation. The whole value is in the failure modes — an abandoned payment, a payment that lands while the submission or return handling fails, an order edited after submission, a duplicate submission — and how paid is distinguished from pending; the `payment_status` element is that signal, so wire it and lock down its visibility (the help text says to make the Order-* fields admin-only) before relying on it. Known limitation, stated by the module: it works well only with off-site gateways; on-site/on-page payment is not properly supported, and the workaround is to move the handler's checkout step earlier (Order information / Review).

---

- Charge a fee for an event registration form.
- Take payment for a membership application.
- Run a quick donation form where the donor names the amount ("Other").
- Sell a promotional or one-off product configured entirely on a form.
- Charge a competition or contest entry fee.
- Take payment for a workshop or class booking.
- Offer priced add-ons via checkboxes, each becoming its own order item.
- Simulate product variations with priced select/radio options.
- Add a flat supplement to any submission with a per-element "top" price.
- Map a computed/hidden "Total price" element to a single order item.
- Charge for a paid advertisement submission.
- Take payment for a permit or document request.
- Sell a sponsorship package through a form.
- Charge a submission or application fee.
- Take payment for a conference place.
- Bill for an inspection or appointment booking.
- Collect a billing email and address from mapped form fields onto the order.
- Multiply a priced item by a submitted quantity element.
- Drive a form-built order straight into Commerce checkout with a preselected gateway.
- Fire downstream webform handlers (email, exports) only after payment completes.
- Let other modules alter the order, order items, or billing profile via dispatched events.
- Keep a back-reference between each submission and its Commerce order.
