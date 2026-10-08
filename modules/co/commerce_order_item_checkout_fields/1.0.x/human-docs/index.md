# Commerce Order Item Fields — manual setup guide

**Commerce Order Item Fields** (`commerce_order_item_checkout_fields`) adds a
Drupal Commerce **checkout pane** that collects extra field data *per order item,
per unit of quantity* — and stores it on the order item rather than on the order
as a whole. The classic example is event tickets: if a cart holds three tickets,
the pane renders three sets of fields so you can capture each attendee's name and
email, kept clearly attached to the ticket it belongs to. It's equally useful for
engraving text, gift messages, or any per-line-item configuration.

The reason it lives on the order item and not the order is precision: a single
order might contain several different tickets or event dates, each needing its own
specific information. Collecting that on the order entity would blur which value
belongs to which item; here every value stays with its order item, which also makes
the data easy to pull into Views for admins.

A checkout pane is **generated automatically** for every order item type that has
at least one qualifying field, so there's no central settings form to fill in —
you add the fields you want, then switch the pane on in your checkout flow. Almost
any field type works (text, email, number, date, list, link, entity reference,
Address, and custom fields); only file/image and Paragraphs fields are excluded,
because they can't be handled safely in a stateless checkout pane (and that
exclusion list is alterable via a hook). The module carries no access role of its
own.

It requires **Drupal 11** and depends on core's **Field** module plus Commerce's
**Checkout**, **Order**, and **Cart** modules.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is no dedicated module settings form. You configure it through the normal
Field UI and checkout-flow screens, described in "How to use it" below.

## Where it lives in the admin menu

You work with this module in two familiar places: the **order item type** fields
and form displays (**Commerce → Configuration → Order item types**), and your
**checkout flow** (**Commerce → Configuration → Checkout flows**), where you enable
the generated pane on the step you choose.

## How to use it

1. **Add fields to an order item type.** Go to
   `/admin/commerce/config/order-item-types/{type}/edit/fields` and add the fields
   you want to collect per item (for example *Attendee name* and *Attendee email*).
2. **Enable the pane in your checkout flow.** At
   `/admin/commerce/config/checkout-flows`, edit your flow and enable the
   automatically generated pane (its label ends with "… fields") on the desired
   checkout step. During checkout the pane renders one set of widgets per unit and
   writes the submitted values back onto the order items.
3. **Pick which fields appear (optional but recommended).** The pane renders
   whatever fields are placed on the order item type's chosen **form display
   mode**. Create a dedicated *Checkout* form display mode to control exactly which
   fields and widgets show up.

### Things worth knowing before you rely on it

- **Best for integer quantities.** The pane is designed for order item types whose
  quantity is always a whole number (like tickets). Someone ordering 50 units means
  50 sets of fields — potentially heavy on the UX — so use it where quantities stay
  reasonable.
- **Combined cart items need "Unlimited" cardinality.** If products can be
  *combined* into one cart line, set those fields' cardinality to **Unlimited** so
  each unit's value is stored as its own field delta. The module warns you (on pane
  save and in the status report / checkout log) if a collected field has limited
  cardinality.
- **Empty values can misalign.** Drupal drops empty field deltas on save, so a
  blank entry for one product can shift the others out of alignment. Avoid this by
  using the pane's **"Require every field for every product"** setting, by marking
  fields required, or by using one composite field per product.
