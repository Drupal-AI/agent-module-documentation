# Configuration

Commerce Order Amend has a small amount of setup: choose which order states can be
amended, decide whether to use stock validation, and grant the amend permission to
the right roles.

## Grant the permission — carefully

Amending a placed order is a **privileged, financially-sensitive** operation: it
changes what was bought and can shift the amount owed. The module provides its own
permission for this — grant it **only to trusted order administrators**, never to
broad or customer-facing roles. Review it at **People → Permissions**
(`/admin/people/permissions`).

Every amendment is written to the Commerce Log audit trail (prefixed "Order
Amended", with SKUs and reasons), so you retain a record of who changed what and why
— but the permission is still your primary control.

## Configure the editable order states

Through the module's admin UI you decide **which order states are editable**. Only
orders in those states will offer the Amend Order tab. Choose the states that match
your fulfilment process (for example allowing amendments while an order is being
prepared but not after it has shipped).

## Stock validation (optional)

If **Commerce Stock** is installed, you can enable stock-availability validation
during an amendment. It respects the always-in-stock flag and handles stock for both
the old and new variation when an item is swapped. Leave it off if you don't use
Commerce Stock.

## Amendment tracking for Views

The module records the type of each amendment (items swapped, added, coupons
changed, and so on) in a multi-value tracking field, so you can build Views filters
to report on which orders were amended and how.

## What to check after configuring

Because amendments force a full order refresh on placed orders, confirm your
promotion and tax setup behaves as you expect when an order is amended — the module
warns staff about side effects, but it's worth validating with a test order that the
balance difference, payment guidance and audit log all read correctly for your
store.
