Delete Commerce Order Periodically bulk-deletes old Commerce orders (and their linked payments) either on demand through a Batch API job or automatically on cron through a queue worker, selected by date.

---

The module (project machine name `delete_commerce_order`, human title "Commerce Order Bulk Delete") adds a single admin form at `/admin/commerce/order-deletion` (a local task "Bulk Delete" on the Commerce order collection). The form has one choice: run now, or schedule on cron. When "periodic cron" is No, submitting runs a Batch API job that loads every `commerce_order` created before the date you pick and deletes each order plus its `commerce_payment` entities. When periodic cron is Yes, the form saves a relative interval (1 month … 5 years) into config; each cron run then queries orders older than that interval and pushes their IDs into the `commerce_delete_order` queue, whose worker (`CommerceOrderDeleteQueue`, 300s/run) deletes them in the background. All deletion queries use `accessCheck(FALSE)`, so the acting administrator's per-order access is not consulted — the route itself is gated by the restricted `administer commerce_order` permission. Deletion is permanent and unrecoverable; the module repeatedly warns you to back up the database first, and to uninstall the module when not in use. It depends on Commerce and Commerce Order and ships no Drush commands, no custom permissions, and no config schema.

---

- Purge test/demo orders after a QA or launch rehearsal before going live.
- Enforce a data-retention policy by deleting orders older than 1, 3, or 6 months, or 1–5 years.
- Automatically prune stale orders on a schedule by enabling the periodic-cron option.
- Do a one-off cleanup of all orders created before a specific past date via the batch job.
- Reduce database size on a store that has accumulated years of completed orders.
- Remove orders together with their `commerce_payment` records in a single operation.
- Run the cleanup in the background via the queue worker so large deletes don't block a request.
- Trim old orders to speed up Commerce order admin views and reports.
- Clean up abandoned/draft orders that predate a chosen cutoff date.
- Support GDPR-style minimization by removing order PII past a retention window (verify obligations first).
- Free storage before a site migration or backup by dropping historically old orders.
- Reset a staging or development copy's order data to a recent window.
- Schedule quarterly or annual archival purges using the interval options.
- Delete orders in tunable chunks (Batch API for foreground, queue for cron) to stay within resource limits.
- Give store admins a self-service bulk-delete UI instead of ad-hoc drush/SQL.
- Log every deletion to the `delete_commerce_order` logger channel for an audit trail of what was removed.
- Combine with a scheduled cron to keep only a rolling window of recent orders online.
- Clear out orphaned orders after uninstalling a payment gateway or test store.
- Confirm the destructive action through the built-in JavaScript confirmation dialog before it runs.
- Pick "Older than N months/years" relative options so the cutoff stays correct as time passes.
