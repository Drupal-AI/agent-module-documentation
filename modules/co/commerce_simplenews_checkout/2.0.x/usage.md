<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Simplenews Checkout provides a Commerce checkout pane that lets customers subscribe to Simplenews newsletters during checkout, using the order's email address.
---
Stores often want to offer newsletter sign-up at the point of purchase. This module adds a Commerce checkout pane plugin (`SimplenewsSubscription`, id `simplenews_subscription`) that renders newsletter checkboxes in the checkout flow. In its configuration form a site builder picks which Simplenews newsletters to offer, the pane label, whether to show it in the review step, and the review label. On the customer-facing pane, the selected newsletters appear as checkboxes; on submit the pane loads or creates a Simplenews `Subscriber` for the order's email (`$this->order->getEmail()`) and subscribes it to each checked newsletter.

The pane defaults to the `summary` checkout step and is administered like any other Commerce checkout pane (permission **`administer commerce_checkout flow`** via the checkout flow config form). The repository also contains legacy Drupal 7-era procedural code in the `.module`/`.install` files (`variable_get`, `db_query`, `check_plain`, `simplenews_subscribe_user`, Rules tokens) that is not executed on Drupal 8+; the functional Drupal 10/11 code path is the `CheckoutPaneBase` plugin. Subscription only ever uses the buyer's own order email and requires no extra permission for the shopper beyond reaching checkout.
---
- Offer newsletter sign-up as a step in Commerce checkout.
- Choose which Simplenews newsletters appear at checkout.
- Set a custom label for the subscription pane.
- Show or hide the subscription choice in the checkout review step.
- Customize the review-step label text.
- Subscribe the buyer's order email to a newsletter on order submit.
- Create a Simplenews subscriber automatically for new emails.
- Place the pane on a chosen checkout step (defaults to summary).
- Let customers opt into multiple newsletters at once.
- Grow a newsletter list from paying customers.
- Add marketing consent capture to the purchase flow.
- Reorder or reposition the pane within the checkout flow.
- Present newsletters only for stores that use Simplenews.
- Keep sign-up tied to the verified order email address.
- Skip the pane display when configured to hide for the review step.
- Integrate transactional purchases with newsletter marketing.
- Configure the pane from the Commerce checkout flow admin form.
- Enable post-purchase newsletter subscriptions without a separate form.
