# Message Digest — agent index

Adds digest (daily/weekly/custom) delivery to Message + Message Notify: messages sent with a digest notifier are
stored and emailed as one periodic digest on cron. Depends on `message_notify` (and `message_subscribe` via
Composer). Provides config entities, Notifier plugins (through message_notify), a queue worker, and two alter hooks.

- **`message_digest_interval` config entities, admin routes, config schema, how intervals map to notifiers** →
  [configure/intervals.md](configure/intervals.md)
- **The notifier plugins, queue worker, deriver — and how to add a custom interval notifier** →
  [plugins/notifiers.md](plugins/notifiers.md)
- **`DigestManager` / `DigestFormatter` services and the cron flow** → [api/services.md](api/services.md)
- **Invited hooks (`hook_message_digest_aggregate_alter`, `hook_message_digest_view_mode_alter`)** →
  [hooks/hooks.md](hooks/hooks.md)

Submodule (own docs):
- `message_digest_ui` → [../../modules/message_digest_ui/1.5.x/agent/start.md](../../modules/message_digest_ui/1.5.x/agent/start.md)

Key facts:
- To digest a notification, send the message with the digest notifier id (e.g. `message_digest:daily`) instead of
  an immediate notifier. `DigestBase::deliver()` writes to the `message_digest` table rather than emailing.
- Ships intervals `daily` (`1 day`) and `weekly` (`1 week`) in `config/install`. Custom intervals = new
  `message_digest_interval` entities with a `strtotime()` string.
- Cron: `message_digest_cron()` → `DigestManager::processDigests()` → per-user items on the `message_digest`
  queue worker → one email via `hook_mail('digest')`.
- No new plugin type manager (notifiers plug into `message_notify`); no Drush. Perm: `administer message digest`.
