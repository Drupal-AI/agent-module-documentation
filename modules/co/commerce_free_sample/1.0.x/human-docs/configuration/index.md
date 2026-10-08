# Configuration

Setting up free samples is a three-part job: create the products you want to give
away, tell the module which of them to offer, and (optionally) restrict which
orders see the offer.

## 1. Create your sample products

Before configuring the module you need actual products to offer. Create them in
Drupal Commerce the usual way, and **price each sample variation at 0** (or
whatever "free" means for your business).

This is important: the sample is added to the order at the **variation's own
price** — it is not a discount or an adjustment. If a sample variation has a
non-zero price, the customer will be charged that amount. Keeping samples priced
at zero is also what makes the feature safe, since the checkout handler charges
whatever price the chosen variation carries.

## 2. Choose the sample pool

1. Log in as a user with the **Administer commerce_product** permission.
2. Go to **Commerce → Free Samples** (`/admin/commerce/free-samples`).
3. Use the autocomplete fields to search for and add each product you want to
   offer as a sample. Use **Add another product** for more rows, and the per-row
   **Remove** button to drop one.
4. **Save.** The list is de-duplicated, compacted, and sorted alphabetically by
   product title on every save, so the customer-facing dropdown stays tidy and
   predictable.

Only **published** products from your pool appear in the checkout dropdown, so an
unpublished or discontinued sample is hidden automatically until you publish it
again.

The settings form controls these values:

- **Sample products** (`free_sample_ids`) — the products offered in the dropdown.
- **Sample product bundle** (`product_bundle`) — the product type treated as a
  "free sample" when the module detects and removes a previously chosen sample.
  The default is `free_sample`.
- **Order-item type** (`order_item_type`) — the order-item type used when the
  sample line is added to the order. The default is `default`.
- **Eligibility field / eligibility values** — optional; see below.

## 3. Optional: restrict who sees the offer

If you set both an **eligibility field** and one or more **eligibility values**,
the sample picker is only offered when *every* item already in the order has a
purchased variation whose eligibility-field value is in your list. If any item
does not qualify, the widget is hidden. Leave these blank to offer the sample on
every order.

## 4. Confirm the checkout placement

The module places its widget on the default Commerce order checkout form display
automatically. To confirm or adjust where it sits, go to **Commerce →
Configuration → Order types → *(your order type)* → Manage form display** and look
at the **Checkout** form mode. You can reposition the **Free sample** field there.

## How it behaves at checkout

On the Order information step, an eligible customer sees the "Select a Free Sample"
dropdown. Choosing a sample adds the selected product's default variation to the
order as a line item (quantity 1, at the variation's price). Choosing a different
sample removes the previous one and adds the new one — one sample per order is
enforced automatically. On any other checkout step the widget is hidden.
