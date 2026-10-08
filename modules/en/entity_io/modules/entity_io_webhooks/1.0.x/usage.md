Automatically delivers an entity's JSON export to external endpoints, email, or FTP when the entity is created, updated, or deleted.

---

Entity IO Webhooks hooks into entity insert/update/delete (and content-moderation transitions) and,
for entity types and bundles you configure, exports the entity to JSON and delivers it to one or more
destinations: an HTTP POST to configured webhook URLs, an email with the JSON attached (via the SMTP
module), or an FTP upload. Global default events and headers are set on a settings form; per-bundle
overrides (events, URLs, headers, mail recipients, FTP host/credentials/path) are configured on the
entity-type pages. Requires the `smtp` module.

---

- POST an article's JSON to an external system whenever it is published.
- Notify a downstream service on every node update via webhook.
- Send a webhook when content of a specific bundle is deleted.
- Trigger different webhooks based on content-moderation state transitions.
- Email a JSON export as an attachment to an editor when content changes.
- Upload each export to a remote FTP server automatically.
- Attach custom HTTP headers (e.g. an auth token) to outgoing webhooks.
- Configure default events and headers once, then override per bundle.
- Enable webhooks only for selected entity types and bundles.
- Fan out one entity event to multiple webhook URLs.
- Integrate Drupal content changes into a CI/automation pipeline.
- Keep an external search index in sync with content changes.
- Push content changes to a headless front end on save.
- Archive every content revision to FTP as JSON.
- Skip webhook firing during Entity IO imports (handled automatically).
