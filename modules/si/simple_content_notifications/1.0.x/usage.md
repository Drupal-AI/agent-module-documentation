Simple Content Notifications emails a fixed list of addresses when nodes are created, updated, or deleted, and periodically emails a digest of content that has gone too long without review.

---

The module wires two independent features onto Drupal's node hooks and cron. The CRUD feature (`hook_ENTITY_TYPE_insert/update/delete` in `.module`) sends one plain-text email per matching change to a comma-separated recipient list, restricted to a chosen set of content types, and only when the site is running on a configured production domain (a dev/test override exists). The review feature runs on `hook_cron`: it queries all nodes carrying a named "last reviewed" date field, collects those older than a relative cutoff (default `-6 months`), and — no more often than a configured interval — emails a single HTML digest listing everything overdue. An admin route `/admin/content/needing_review` renders the same overdue list as a live report. There are no subscribe/unsubscribe endpoints and no per-user preferences: recipients are set by an administrator in two config forms gated by the `administer content notifications` permission. Notifications never mail the acting editor (their address is filtered out of the recipient list). The module ships no dependencies beyond core node, and stores the review "next send" date in the State API rather than config so it stays per-environment.

---

- Email an editorial team whenever an Article is published or edited.
- Notify a site owner when any node is deleted.
- Send content-change notices only for specific content types (e.g. `page`, `news`).
- Suppress notifications on staging/dev by matching a production domain string.
- Deliberately allow notifications in dev/test for debugging by ticking the in-dev option.
- Keep the acting editor from being emailed about their own change.
- Flag content for periodic review using a custom "last reviewed" date field.
- Email a weekly digest of everything overdue for review.
- Change the review cutoff (e.g. `-3 months`, `-1 year`) via a relative date string.
- Restrict the review digest to published nodes only.
- Give reviewers a live `/admin/content/needing_review` report with edit links.
- Set a custom subject line for the review digest email.
- Throttle review emails with a "time between notifications" interval (default `+7 days`).
- Reset the per-environment next-send date after restoring a database.
- Log why a notification was or was not sent to the `simple_content_notifications` channel.
- Turn logging off to keep the watchdog log quiet on a busy site.
- Replace a heavier Rules/ECA/Workflow setup when only simple email alerts are needed.
- Route review digests through an HTML-capable mailer (e.g. configure the site mail system for HTML).
- Audit which content types currently generate change notifications.
- Confirm cron is running by watching the next-send date advance.
- Add review tracking to any content type simply by giving it the named date field.
- Document current recipients and content-type scope during a site handover.
