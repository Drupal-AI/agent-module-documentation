Syncs a Drupal Commerce store — carts, customers, products, promotions and orders — to Mailchimp's E-Commerce API so Mailchimp marketing automations can run against live store data.

---

Mailchimp E-Commerce (3.x) connects Drupal Commerce to Mailchimp using the first-party `mailchimp/marketing` PHP library (Mailchimp Marketing API 3.x). After you enter a Mailchimp API key and create or connect a Mailchimp store from the admin UI, the module listens to Commerce cart, order, product and promotion events and mirrors those entities into Mailchimp. Every outbound API call is deferred into a Drupal queue and processed on cron, so a slow or failing Mailchimp request never blocks the shopper's checkout. Products and product variations are mapped to Mailchimp product fields through an admin mapping form, and Commerce order-workflow transitions are mapped to Mailchimp financial/fulfillment states through a second mapping form. A checkout pane lets shoppers opt in to your Mailchimp audience, with optional double opt-in. Batch forms let you back-fill existing products, orders and promotions into a freshly connected store. This branch does not depend on the contrib `mailchimp` module because it uses a different (first-party) API library.

---

- Recover abandoned carts: Commerce carts with an email are synced to Mailchimp so its Abandoned Cart automation can email shoppers who did not check out.
- Fire product-retargeting and best-customer automations off synced product and order data.
- Sync the full product catalog (products + variations) to Mailchimp for use in product recommendation blocks and campaigns.
- Create a new Mailchimp E-Commerce store from Drupal, pre-populated from your default Commerce store, at `/admin/config/services/mailchimp-ecommerce/store-create`.
- Connect Drupal to an existing Mailchimp store by selecting it after entering your API key.
- Update the connected Mailchimp store's details from `/admin/config/services/mailchimp-ecommerce/store-update`.
- Delete a Mailchimp store from `/admin/config/services/mailchimp-ecommerce/store-delete`.
- Map Commerce product/variation fields (description, image, inventory quantity) to Mailchimp product properties via the Product Property Map form.
- Map each Commerce order type's workflow transitions (place, validate, process, fulfill, cancel) to Mailchimp order states (paid, pending, refunded, cancelled, shipped) via the Order Workflow Map form.
- Add a "Subscribe to our newsletter" checkbox to checkout via the `mailchimp_subscription_information` checkout pane, optionally shown in the review step.
- Require double opt-in for newsletter subscribers so they receive a Mailchimp confirmation email before being added as subscribed members.
- Send new/updated/deleted Commerce products and variations to Mailchimp automatically as they change.
- Send cart create/update/empty events to Mailchimp so cart contents stay current for automations.
- Convert a Mailchimp cart into a Mailchimp order automatically when a Commerce order is placed.
- Push order state changes (paid, pending, refunded, cancelled, shipped) to Mailchimp as Commerce order transitions fire.
- Sync Commerce promotions and coupons to Mailchimp as promo rules and promo codes.
- Attach Mailchimp campaign attribution: when a shopper lands from a Mailchimp email (`?mc_cid=`), the campaign id and landing site are captured in session and sent with the cart/order.
- Back-fill an existing catalog into a new store with the Product Sync batch form.
- Back-fill historical orders with the Order Sync batch form and promotions with the Promo Sync batch form.
- Tune batch size (1–10000, Mailchimp suggests ≤5000) to control how many entities are pushed per batch operation.
- Inspect connected Mailchimp stores from the CLI with `drush mailchimp-ecommerce:store` (alias `mcec:store`).
- Deduplicate outbound work automatically: identical queued sync items are collapsed and delete events purge pending sync items for the same entity.
