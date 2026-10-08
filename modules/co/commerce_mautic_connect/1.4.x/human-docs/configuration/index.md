# Configuration

Commerce Mautic Connect is built around a settings area (organised into feature
tabs) plus the underlying Mautic connection. The connection itself is owned by the
**Advanced Mautic Integration** module, and Commerce Mautic Connect layers the
commerce features on top.

## 1. Connect your Mautic instance

Before Commerce Mautic Connect can send anything, the **Advanced Mautic
Integration** module needs to be pointed at your Mautic server with valid API
credentials (Mautic base URL and API key or OAuth credentials).

Keep those Mautic credentials out of version control and store the secret in an
environment variable rather than hard-coding it. With DDEV you can set it once
with the built-in dotenv command:

```bash
ddev dotenv set .ddev/.env --mautic-api-secret='<your secret>'
ddev restart
```

Keep `.ddev/.env` out of version control.

## 2. Configure the commerce features

The module's settings are grouped into feature tabs. Depending on which features
you use, you can set:

- **Coupon tag prefix** — the prefix used when tagging Mautic contacts with the
  coupon codes they redeem (for example `coupon:`, `promo-`, or `discount_`).
  Each coupon on an order becomes its own tag, so you can build segments like
  "customers who used SUMMER-20".
- **Base currency for metrics** — the currency the RFM customer metrics (lifetime
  value, average order value) are calculated in. With Commerce Exchanger
  installed, amounts in other currencies are converted automatically.
- **Abandoned-cart / magic-link options** — controls around the cart sync and the
  secure passwordless magic links that restore a cart across devices and can
  auto-log a customer in when the cart belongs to their account.
- **Template preview** — a built-in preview tool lets you test how the cart email
  will render before you use it in a live Mautic campaign.

The module creates the custom fields it needs inside Mautic automatically, so you
do not have to define recency/frequency/monetary fields by hand.

## Access to the settings

The module does not define its own permissions. Its settings page
(`/admin/commerce/config/mautic-connect`) and the template-preview tool are
governed by the core **Administer site configuration** permission
(`administer site configuration`). Because these settings decide what customer
data is sent to an external service, grant that permission only to trusted
administrator roles.

## A note on privacy

Commerce Mautic Connect sends customer and cart data — including data about
anonymous visitors tracked by Mautic's cookie — to your Mautic instance. Before
enabling it in production, confirm this fits your privacy policy and any
applicable data-protection rules, and make sure your Mautic instance is itself
secured.

## Historical sync (optional)

The module ships Drush commands to backfill data — for example, batch-syncing
coupon tags from all existing orders, or force-syncing metrics for all customers
or specific users — so you can populate Mautic with history rather than waiting
for new activity.
