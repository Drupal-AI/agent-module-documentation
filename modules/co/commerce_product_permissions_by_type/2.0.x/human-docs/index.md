# Commerce Product Permissions by Type — manual setup guide

**Commerce Product Permissions by Type** (`commerce_product_permissions_by_type`)
generates a pair of permissions for every Commerce product type you have defined —
one that controls who may **view** products of that type, and one that controls who
may **add them to the cart**. That lets you open up or lock down a whole bundle of
products per role: a "wholesale" product type visible and purchasable only by a
wholesale role, a "members" catalogue hidden from the public, and so on.

Once enabled, the permissions appear automatically on the standard
**People → Permissions** page — two lines per product type, named
"{Product type}: View products" and "{Product type}: Add products to cart". You
assign them to roles like any other permission; there is no separate settings form.
The module hooks into product view-access and, when a user lacks the add permission
for a type, hides the add‑to‑cart widgets and shows a "log in to buy" link
(anonymous) or an access-denied message (logged in) instead of the purchase button.

It depends on **Commerce Cart** (`commerce_cart`) and works for any number of
product types.

There is one important caveat to understand before you rely on this for hiding
products. The **view** permission is *additive*: granting "{type}: View products"
to a role lets those users see that type, but Commerce core also ships a blanket
grant that lets everyone view products. So to make viewing genuinely restrictive,
you must **remove core Commerce's default product-view grant** so that *only* the
per-type permission opens access. If you skip that step, the per-type view
permission will widen access but never narrow it. The add-to-cart gating is applied
at the form level, consistent with how the module is designed. This project does
not carry official security-advisory coverage, so treat access decisions here as a
storefront-merchandising control and test them against your own roles before
launch.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Commerce Cart.

There is **no configuration form** — you assign the generated permissions on the
standard permissions page, described below.

## Where it lives in the admin menu

The module adds no page of its own. Its generated permissions live on
**People → Permissions** (`/admin/people/permissions`), grouped with the other
Commerce product permissions.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Go to **People → Permissions**. For each product type you will find
   "{Product type}: View products" and "{Product type}: Add products to cart".
3. Grant those permissions to the roles that should see or buy each type.
4. To make **view** restrictions actually bite, remove Commerce core's blanket
   product-view grant so only your per-type permission allows viewing. Then test as
   an anonymous user and as each role to confirm the catalogue behaves as intended.
