Provides a Views query backend that turns the Government Notify message log into a Views base table so you can build delivery dashboards.

---

GovUK Notify Views Backend is a submodule of GOV Notify Integration. It registers a Views base table, "GovUK Notification Message Log", whose rows are fetched at query time from the parent module's Notify service (`listNotifications`), not from a local database table. Each returned notification becomes a Views result row exposing standard fields (id, type, created_at, updated_at, sent_at, status, created_by, body, subject), and it adds three exposed filters — by id/reference, by message type (email/sms/letter), and by delivery status (sending, delivered, failed, and the three failure variants). Because it depends on `govuk_notify` and core `views`, it lets public-sector sites present sent-message status inside ordinary Views UI without writing API code. Note the query has no paging yet and mutating filters map to the Notify API's own filter parameters.

---

- Build an admin dashboard listing recently sent Notify messages and their delivery status.
- Show a table of failed / temporary-failure messages so staff can follow up.
- Filter the message log by delivery status (sending, delivered, failed, permanent-failure, temporary-failure, technical-failure).
- Filter the message log by message type: email, sms, or letter.
- Look up a single message by its Notify id/reference via the id filter.
- Display message subject and body columns alongside timestamps in a View.
- Show created_at / updated_at / sent_at timestamps for each notification.
- Expose the type and status filters to end users as a Views exposed form.
- Create a block View of the latest N notifications for an operations landing page.
- Provide a read-only audit surface of what the site has sent through Notify.
- Combine type + status filters to, e.g., list only failed SMS messages.
- Feed the message log into any Views display style (table, grid, unformatted list).
- Give non-developers a Views-UI way to inspect Notify delivery without API access.
- Report on message volume by type for a given service (uk/ca/au) configured in the parent module.
- Surface Notify's `created_by` field to see which sender/account produced each message.
