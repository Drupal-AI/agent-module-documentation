Adds daily/weekly (or custom-interval) digest delivery to the Message + Message Notify stack: instead of sending each Message notification immediately, messages are collected per user and emailed as a single periodic digest on cron.

---

The module registers **Digest notifier plugins** (via Message Notify's notifier plugin manager) derived from
`message_digest_interval` **config entities** — `daily` (`1 day`) and `weekly` (`1 week`) ship by default, and
any new interval entity (a `strtotime()`-compatible string) auto-creates a matching notifier. When a message is
sent with a digest notifier (`$notifier_name`), `DigestBase::deliver()` does not email it; it inserts a row into
the `message_digest` table (receiver, entity_type/id grouping, notifier, timestamp) for later delivery. On cron,
`message_digest_cron()` → `DigestManager::processDigests()` finds users with pending messages whose interval has
elapsed (tracked in State) and queues per-user work to the `message_digest` **queue worker**, which renders the
grouped messages through `DigestFormatter` (using the message view modes `mail_subject`/`mail_body`) and sends
one email via `hook_mail()`. Two alter hooks (`hook_message_digest_aggregate_alter`,
`hook_message_digest_view_mode_alter`) let modules regroup, reorder, change view modes, or veto delivery.
Digest interval entities are managed at `admin/config/message/message-digest` (perm `administer message digest`).
The optional **message_digest_ui** submodule adds a per-user notification-frequency field and Flag-based actions.
Rows are cleaned up automatically when the referenced message or user is deleted.

---

- Send subscription notifications as a daily digest instead of one email per event.
- Send a weekly roundup email of a user's message notifications.
- Define a custom digest interval (e.g. every 3 days) via a config entity.
- Batch high-volume activity so users aren't flooded with individual emails.
- Group digest contents per entity (e.g. per node/term) or globally.
- Let each user pick their own notification frequency (with message_digest_ui).
- Reorder or filter which messages appear in a digest via an alter hook.
- Change the view modes used to render digest messages, or stop a digest from sending.
- Deliver digests on cron using a queue so large sends are chunked.
- Track per-user/per-interval last-sent time so digests fire on schedule.
- Provide "send immediately" as an option alongside digest intervals.
- Integrate with Message Subscribe so subscribers receive digested notifications.
- Skip delivery for blocked users via the view-mode alter hook.
- Customise the digest email subject (defaults to "<site/entity> message digest").
- Manage available digest intervals from an admin list UI.
- Clean up digest bookkeeping automatically when messages or users are deleted.
- Convert an existing immediate-notify flow to digests by swapping the notifier id.
- Aggregate all content into one digest for opted-in users via the aggregate alter hook.
- Run digests for any Message-based notification type, not just a fixed one.
- Add per-entity flag actions to set a user's digest interval (with message_digest_ui).
