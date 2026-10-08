# Configuration

Setting up the dashboard has three parts: grant the right permissions, decide what the
dashboard displays, and optionally send store admins straight to it.

## 1. Assign permissions

The module provides two permissions. Go to **People → Permissions**
(`/admin/people/permissions#module-commerce_store_dashboard`) and assign them thoughtfully:

- **Access own store dashboard** (`access own commerce_store dashboard`) — give this to
  store owners. Combined with actually owning a store, it lets them view *their own* store's
  dashboard.
- **Bypass commerce_store dashboard access** (`bypass commerce_store dashboard access`) —
  this is a **restricted** permission that lets a user view **every** store's dashboard.
  Give it only to trusted staff who manage all stores, since it reveals every store's data.

### How access is decided

When someone requests `/store/{commerce_store}/dashboard`, the module allows it only if they
hold the **Bypass** permission, **or** they own that store (the store's owner ID matches
their user ID) **and** hold the **Access own store dashboard** permission. Otherwise access
is forbidden. Ownership is enforced on the server, and results carry the correct per-user
cache contexts, so a store owner can never see another owner's dashboard.

## 2. Lay out the dashboard

The dashboard renders the store entity through a **`dashboard`** view mode. Configure it at
**Commerce → Configuration → Stores → Store types → *(your store type)* → Manage display**,
choosing the **Dashboard** view mode. Arrange the fields there, and use Drupal's core Block
Layout to place blocks, views, or reports (for example order or product listings) so store
owners see the KPIs and management tools you want them to have.

## 3. (Optional) Redirect store admins to the dashboard

You can send store administrators straight to the dashboard. In each store type's
configuration at **Commerce → Configuration → Stores → Store types → *(your store type)***
(`/admin/commerce/config/store-types/{store_type}`), enable the **Dashboard redirect** for
store administrators.

## Notes

This module does not mutate any data — it is purely a display-and-access layer over the
store entity. The main thing to keep an eye on is the **Bypass** permission: keep it limited,
because it exposes every store's dashboard.
