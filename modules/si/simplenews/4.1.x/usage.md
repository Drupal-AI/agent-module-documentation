Simplenews publishes and sends email newsletters to lists of subscribers, with double opt-in subscription, per-newsletter configuration, and queued (spooled) sending via cron or immediately.

---

Simplenews models three concepts: a **newsletter** (a `simplenews_newsletter` config entity — a category/list a subscriber can join, e.g. "Weekly digest"), a **subscriber** (a `simplenews_subscriber` content entity keyed by email, holding a multi-value `subscriptions` field referencing newsletters), and an **issue** (an ordinary node whose content type carries a `simplenews_issue` field — the actual email to send). Site builders create newsletters at **Admin → Configuration → Web services → Simplenews** (`simplenews.newsletter_list`), enable the issue field on chosen node types, and manage subscribers at **Admin → People → Subscribers**. Visitors subscribe through the **Simplenews subscription block** or the `/simplenews/subscriptions` page; anonymous subscriptions use a hashed **double opt-in** confirmation email before a subscriber becomes ACTIVE. Sending does not happen inline: publishing/activating an issue adds one spool row per recipient via the `simplenews.spool_storage` service, and the `simplenews.mailer` service drains that spool — either immediately (batch) or throttled during `hook_cron`, controlled by the `mail.use_cron` and `mail.throttle` settings. Which subscribers receive an issue is decided by a pluggable **recipient handler** (`simplenews_recipient_handler` plugin type; the default `simplenews_all` sends to all active subscribers of the newsletter). Developers get the `simplenews.subscription_manager` service to subscribe/unsubscribe in code, several hooks (`hook_simplenews_subscribe`, `hook_simplenews_mail_result_alter`, etc.), Drush commands (`simplenews:spool-send`, `simplenews:spool-count`), and per-newsletter settings for format (HTML/plain), from address/name, subject, priority and read receipts. Note the deliberate uninstall step: settings offer a **Prepare uninstall** form because subscriber data and fields must be cleaned up first.

---

- Publish a periodic email newsletter (e.g. weekly digest) to opted-in subscribers.
- Let anonymous visitors subscribe via a block placed in a sidebar or footer.
- Offer a full subscriptions management page at `/simplenews/subscriptions`.
- Require double opt-in: send a hashed confirmation email before activating a subscriber.
- Run several independent newsletters (categories) a user can join separately.
- Turn a node (article/page) into a newsletter issue by attaching the `simplenews_issue` field to its content type.
- Send an issue immediately from the node's Newsletter tab, or queue it for cron.
- Throttle large sends to N mails per cron run to respect mail-server limits.
- Send a test email of an issue to specific addresses before the real send.
- Send HTML or plain-text newsletters, with an auto-generated plain-text alternative.
- Personalize subject/body with tokens (subscriber mail, confirm/manage URLs, node title).
- Manage subscribers in bulk: mass subscribe, mass unsubscribe, and CSV-style export.
- Let logged-in users manage their newsletters from a tab on their user profile.
- Add newsletter opt-in checkboxes to the user registration form.
- Subscribe or unsubscribe an address programmatically via the subscription manager service.
- Check in code whether an address is already subscribed to a given newsletter.
- Track subscribe/unsubscribe history per subscriber (`simplenews_subscriber_history`).
- Restrict who can receive an issue with a custom recipient handler plugin.
- Request a read receipt or set message priority per newsletter.
- Set a default from-name and from-address for outgoing newsletters.
- Automatically tidy unconfirmed subscriptions after a configurable number of days.
- Drain the mail spool manually from the CLI with `drush simplenews:spool-send`.
- Check how many mails are pending in the spool with `drush simplenews:spool-count`.
- React to a subscribe/unsubscribe event with `hook_simplenews_subscribe` / `hook_simplenews_unsubscribe`.
- Reclassify per-mail send results (single vs global failure) with `hook_simplenews_mail_result_alter`.
- Gate newsletter admin, subscription admin, sending, and subscribing with distinct permissions.
- Export newsletter settings as configuration to deploy between environments.
- Redirect subscribers to a custom page after confirming subscribe/unsubscribe.
- Migrate Simplenews newsletters, issues and subscribers from Drupal 7 (bundled migrations).
