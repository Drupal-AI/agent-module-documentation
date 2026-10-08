# Delete Commerce Order Periodically — manual setup guide

**Delete Commerce Order Periodically** (`delete_commerce_order`) bulk‑deletes
Commerce orders using batch operations (and a queue worker), so you can clear out
old or test orders without removing them one at a time. It builds on Drupal
Commerce and requires the Commerce and Commerce Order modules.

The typical use is periodic cleanup — purging test orders left over from
development, or removing stale orders in bulk on a maintenance schedule. The
deletion form is gated by the **administer commerce_order** permission, which is
the correct, strong permission to require for an action of this weight.

> ## ⚠️ This is destructive and irreversible
>
> Deleting orders **cannot be undone**, and orders are not ordinary content —
> they hold **financial records and customer personally identifiable information
> (PII)**. Before you use this module:
>
> - **Back up your database first.** There is no rollback.
> - **Verify exactly what will be deleted** before you run the batch.
> - **Keep the `administer commerce_order` permission to trusted administrators
>   only.**
> - **Consider your legal record‑retention obligations** — you may be *required*
>   to keep order records for a period of time for tax, accounting, or consumer‑
>   protection reasons. Do not delete records you are obliged to retain.
>
> The module's own documentation recommends taking a database backup before
> enabling it, and uninstalling it when you are not actively using it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (and its Commerce dependencies).

There is no general settings page to configure — the module provides a deletion
action rather than ongoing settings. The workflow is described below.

## Where it lives in the admin menu

The order‑deletion form is at **Commerce → Order deletion**
(`/admin/commerce/order-deletion`), available to users with the **administer
commerce_order** permission.

## How to use it

1. **Take a database backup.** This is the single most important step — deletion
   cannot be reversed.
2. Go to **Commerce → Order deletion** (`/admin/commerce/order-deletion`).
3. Set the deletion criteria for the orders you want to remove.
4. **Review carefully** which orders match before confirming — remember these are
   financial and personal records.
5. Run the deletion; it processes the matching orders in a batch (or via the
   queue worker).

When you have finished a cleanup, consider uninstalling the module until you next
need it, as its own documentation recommends.
