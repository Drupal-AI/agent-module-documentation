# Commerce Cart Estimate — manual setup guide

**Commerce Cart Estimate** (`commerce_cart_estimate`) adds a small form to the
shopping-cart page that lets customers estimate their **shipping and tax costs
before they commit to checkout**. The shopper picks a country and enters a postal
code, and the form returns an estimate based on the shipping methods and tax rules
your store already has configured — the same configuration that will be used at
checkout. The goal is cost transparency: fewer surprises at the payment step, and
fewer abandoned carts.

The estimate is provided through a **Views area handler**, so you add it to the
cart form view rather than configuring it on a settings page. Because it only
supplies partial customer-profile data (a country and postal code) to the
calculation, it may not be compatible with every possible tax rate or shipping
method — always confirm that the number it shows matches what checkout actually
charges. The countries offered in the estimate form are inherited from the store's
configured **Shipping countries** list.

Commerce Cart Estimate depends on **Commerce Shipping** (`commerce_shipping`) —
it is the only currently supported companion module — and works on Drupal 9.3, 10,
and 11. It adds no admin settings page and no permissions of its own; everything
happens inside the cart form view.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and add the estimate form to your cart view.

There is **no configuration page** for this module — it has no settings form. You
set it up entirely from the cart form view, described in "How to use it" below.

## Where it lives in the admin menu

Commerce Cart Estimate adds no admin page of its own. You configure it from the
**Views UI** by editing the cart form view at
`/admin/structure/views/view/commerce_cart_form` (**Structure → Views → Cart
form**). The list of countries it offers comes from your store's **Shipping
countries** setting under **Commerce → Configuration → Stores**.

## How to use it

1. Make sure **Commerce Shipping** is installed and you have at least one shipping
   method and (optionally) tax rules configured, so there is something to
   estimate.
2. Go to **Structure → Views → Cart form**
   (`/admin/structure/views/view/commerce_cart_form`).
3. Decide where the estimate should appear — most stores add it to the view's
   **Footer**, though the **Header** works too.
4. Click **Add** on that section and search for **Cart estimate form**.
5. Add the handler, configure any options it offers, and **Save** the view.

Once saved, the cart page shows the estimate form. Enter a country and postal code,
and the form returns the estimated shipping and tax. Test a few addresses and
compare the results against a real checkout to be sure the estimate lines up with
what customers will actually pay.
