# Configuration

There's no settings form to fill in — the module's "configuration" is the queue
screen it provides and the Views config behind it. This page explains how to use
the screen, and how to fix or rebuild it if the default view didn't install.

## The queue screen

Go to **Content → Salesforce Push Queue** (`/admin/content/salesforce-push-queue`),
which requires the Salesforce Suite's **administer salesforce** permission. You'll
see one row per queued push item, with columns for the mapping name, entity id,
operation (`create` / `update` / `delete`), failure count, last failure message,
and the claim-expiry indicator.

### Filtering and sorting

Because this is an ordinary View, you can filter and sort:

- **Filter by mapping name** — the exposed mapping filter only lists mappings that
  currently have queued items, so an empty queue means an empty list.
- **Filter by operation** to isolate, say, failing delete syncs.
- **Sort by failure count** to bring the worst offenders to the top.
- The **expiry indicator** shows *Not set* when no lease is held, a red marker when
  the lease has lapsed (the item is stuck), and a green marker when the item is
  currently claimed.

The failure-message column is cleaned up for readability: the module strips the
repetitive "Queue item … failed … times. Exception while pushing entity …" prefix
so you see just the underlying Salesforce error. (This cleanup only happens on the
shipped view — a custom view of the queue shows the full raw message.)

## Row operations

Each row has two operations, also available as bulk actions when you select
multiple rows:

- **Reset failures** — clears the item's failure count and its stored failure
  message, so the Salesforce Suite will retry it on the next cron run. Use this
  after you've fixed whatever caused the failures (for example a bad field
  mapping).
- **Reset expiration** — zeroes the item's claim lease, so a stuck item that's
  still marked as "leased" becomes immediately claimable again. Use this to release
  items after a Salesforce outage so the backlog reprocesses.

Both operations require the **administer salesforce** permission and are
CSRF-protected, then return you to the same filtered/paged view.

**Processing the queue itself is unchanged** — this module doesn't drain the queue.
The Salesforce Suite processes it on cron (`drush cron`, or
`drush queue:run cron_salesforce_push`).

## If the default view is missing

As noted in [Installation](../installation/index.md), the shipped view
(`views.view.salesforce_push_queue`) declares a config dependency on the
**View Custom Table** module that isn't a declared dependency of this module, so on
a site without `view_custom_table` the view is dropped on install. You have two
options:

1. **Install View Custom Table and re-import the view:**

   ```bash
   drush en view_custom_table -y
   drush cim --partial --source=web/modules/contrib/salesforce_push_queue_ui/config/install
   ```

2. **Build your own view** on the `salesforce_push_queue` base table (base field
   `item_id`). All the queue's columns are registered as Views fields, filters,
   sorts, and arguments regardless of whether the default view exists — so you can
   add the fields you need (name, entity_id, failures, last failure message, the
   expiry field, and the **Operations** field), plus a `failures >= 1` filter to
   show only failing items.

If you build a custom view, keep the default table alias so the operations column
can resolve item ids, and note that the failure-message prefix is only stripped on
a view whose id is exactly `salesforce_push_queue`.
