Views Send lets you mass-mail the rows of a View: add its "Global: Send email" field to a View, select rows (or all), fill in a message form, and send — either directly via the Batch API or queued to a spool table and delivered on cron.

---

The module ships a Views field plugin (`views_send_bulk_form`, class `ViewsSend`, extending
core's `BulkForm`) that renders per-row checkboxes plus a "Send email" action on any View that
exposes an email column. Building a mailing is a View-building task: create a page/block display,
add a column containing recipient email addresses (and optionally a recipient-name column), then
add the "Global: Send email" field. At send time the user completes a message form — From
name/address, subject, body, priority, extra headers, optional carbon-copy to the sender — and
per-row tokens personalize each message from that row's field values (row tokens work even
without the Token module; site/global tokens need it). Messages are either sent immediately via
Batch API or inserted into the `views_send_spool` table and flushed by `views_send_cron()` in
batches of `throttle` per run, with `retry` attempts and optional `spool_expire` retention.
Global settings (throttle, retry, spool_expire, debug logging) live at
`/admin/config/system/views_send` (route `views_send.configure`, permission
`administer views_send`); sending is gated by `mass mailing with views_send` and attachments by
`attachments with views_send`. Optional integrations: Mime Mail (HTML + attachments), Token
(context tokens), and Rules (events `MailSentEvent`, `MailAddedEvent`, `AllMailAddedEvent`
declared in `views_send.rules.events.yml`).

---

- Send a newsletter to everyone listed in a "subscribers" View.
- Email all users in a role by exposing their email in a users View.
- Notify event registrants selected from a registrations View.
- Message a filtered subset of customers using exposed View filters, then send.
- Personalize each email with row tokens (e.g. recipient name, order number).
- Queue a large send to the spool table and drip it out on cron.
- Throttle delivery to N messages per cron run to respect provider limits.
- Send immediately via Batch API for small, time-sensitive blasts.
- Send rich HTML emails and attachments when Mime Mail is enabled.
- Attach a file (e.g. a PDF flyer) to a bulk send with the attachments permission.
- BCC/carbon-copy the sender a copy of the outgoing message.
- Set message priority headers (High/Low) for a campaign.
- Add custom headers (e.g. Reply-To) to outgoing messages.
- Retry failed spooled messages up to a configured number of attempts.
- Retain successfully sent spool rows for a number of days for auditing.
- Log every outgoing message to the system log via the debug setting.
- Trigger Rules reactions when a message is sent or added to the spool.
- Re-use a saved View (with exposed filters) as a reusable mailing tool.
- Send a one-off announcement to a hand-picked selection of content authors.
- Build an internal "email these nodes' authors" workflow from the content View.
- Preview the assembled headers and From address before sending.
- Grant editors mass-mail rights without full admin via the dedicated permission.
