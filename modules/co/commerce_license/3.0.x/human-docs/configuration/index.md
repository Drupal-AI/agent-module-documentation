# Configuration

Commerce License has no single settings form. Instead you enable two **entity
traits** across your Commerce configuration and then set a license type and
expiration on each product variation you want to sell as a license. This page
walks through that wiring in order.

Everything below requires the **Administer commerce_license** permission (or the
Commerce administrator role).

## The full wiring for an expiring license

Work top to bottom — each step feeds the next:

1. **Checkout flow** — under **Commerce → Configuration → Checkout flows**
   (`/admin/commerce/config/checkout-flows`), edit the flow your store uses and,
   on the "Login or continue as guest" pane, set **Guest checkout: Not allowed**.
   Licenses must be attached to a real user account, so guest checkout has to be
   off.
2. **Order type** — under **Commerce → Configuration → Order types**
   (`/admin/commerce/config/order-types`), make sure your order type uses that
   checkout flow.
3. **Order item type** — under **Commerce → Configuration → Order item types**
   (`/admin/commerce/config/order-item-types`), enable the trait **"Provides an
   order item type for use with licenses"**.
4. **Product variation type** — under **Commerce → Configuration → Product
   variation types** (`/admin/commerce/config/product-variation-types`), enable the
   trait **"Provides a license"**, and set its **order item type** to the one from
   step 3.
5. **Product type** — make sure your product type uses that variation type.
6. **Product variation** — finally, on each individual variation, set its **License
   type** and its **License expiration** (a license period — see below).

Once this is done, buying that variation issues and activates a license for the
buyer automatically, and the granted access (e.g. a role) is added. When the
license later expires, the access is removed.

## Choosing what a license grants — License type

The **License type** is the "bundle" of the license and decides *what access it
grants*. The built‑in type is **role**: it adds a chosen Drupal role to the buyer
while the license is active and removes it when the license ends. (On the user's
edit form that granted role shows as checked‑and‑locked, so it can't be removed by
hand.)

You choose the allowed license types per product variation type, and set the
specific type on each variation. License types are listed and made fieldable at
**Commerce → Configuration → Licenses → License types**
(`/admin/commerce/config/licenses/license-types`). Developers can add their own
type (for example to provision a remote service instead of a role) by implementing
a `CommerceLicenseType` plugin — see the [`agent/`](../agent/start.md) plugin
docs.

## Choosing when a license expires — License period

The **License expiration** on a variation is a **License period** plugin. Three
are built in:

- **Unlimited** — the license never expires (perpetual access).
- **Rolling interval** — expires a set interval after it starts, e.g. 30 days or 1
  year after activation.
- **Fixed reference date interval** — expires at intervals anchored to a fixed
  date, e.g. always the 1st of the month or the end of the calendar year.

Expiration is enforced automatically: **cron** finds active licenses whose expiry
has passed and queues background jobs (on Advanced Queue) to expire them, which
revokes the granted access. Make sure cron runs regularly.

## Subscription‑renewing licenses (optional)

To have a license renew on a billing cycle instead of simply expiring, install the
**Commerce Recurring** module, then on the product variation type also enable the
**"Allow subscriptions"** trait, and on the variation set **Subscription type =
License**, **expiration = Unlimited**, and choose a **Billing schedule**. The
license then renews each cycle rather than ending.

## Managing issued licenses

All licenses that have been created are listed at **Commerce → Licenses**
(`/admin/commerce/licenses`), where you can view, edit, and delete them. Each
license moves through a state‑machine lifecycle — new, pending, active,
renewal in progress, suspended, expired, revoked, canceled — and you can
transition a license (for example to **suspend** or **revoke** someone's access)
from there.

## Permissions

Commerce License adds the **Administer commerce_license** permission (flagged as
security‑sensitive), which grants full control of licenses and the license
configuration pages. In addition, the entity generates the usual granular
per‑type permissions (view/update own or any license of a given type). Grant these
on **People → Permissions**.
