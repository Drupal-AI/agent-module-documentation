# Commerce Store Dashboard — manual setup guide

**Commerce Store Dashboard** (`commerce_store_dashboard`) gives each Drupal Commerce store
its own dashboard page for store owners and managers. It adds a `dashboard` view mode to the
store entity and a route at `/store/{commerce_store}/dashboard` that renders the store in
that view mode — so you can compose a management/reporting overview per store using Drupal's
core Block Layout and Field UI, without building a custom page.

It solves a real need on multi-store and marketplace sites: giving a store owner a
self-service place to see and manage their own store, while keeping the "see any store"
capability limited to trusted staff. Access is decided server-side by a custom access check,
not a blanket permission — a user may view a store's dashboard if they hold the powerful
**Bypass** permission, or if they **own** the store and hold the **own-dashboard**
permission.

The module depends only on **Commerce Store** (`commerce_store`) and provides two
permissions of its own. It introduces no mutating or anonymous endpoints — it is a display
and access layer over the existing store entity.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the module.
2. [Configuration](configuration/index.md) — assign permissions, lay out the dashboard view
   mode, and optionally redirect store admins to it.

## Where it lives in the admin menu

Each store's dashboard is at `/store/{commerce_store}/dashboard` (where `{commerce_store}`
is the store ID); a contextual link on the store also leads there. You lay out what appears
on it by editing the store's **`dashboard`** view mode in **Manage display**. Permissions
are set at **People → Permissions** (`/admin/people/permissions#module-commerce_store_dashboard`).
