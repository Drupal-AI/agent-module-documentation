# Configuration

HTTP Client Log has two things you interact with: a **settings form** that governs
the module's logging behavior, and the **log viewer** where you read what it
captured. Before you turn logging on, please read the privacy note at the end of
this page — this log can contain credentials and personal data.

## Open the settings form

1. Log in as a user with permission to administer site configuration.
2. Open the module's settings form — the settings live in the
   `http_client_log.settings` configuration, reachable from the module's entry on
   the **Extend** page (its "Configure" link) or from the admin configuration menu.

The settings form controls how the module logs — for example whether logging is
active and how much of each request is recorded. Adjust it to match your
investigation, then save. Because the exact fields can change between releases, use
the on-form descriptions as the authority for what each option does.

> **Turn logging off when you are done.** This is a debugging aid, not something to
> leave running. The safest posture is to enable it for a specific investigation and
> disable it (or uninstall the module) afterwards.

## The log viewer

Once requests are being logged, browse them at **Reports → HTTP Client Log**
(`/admin/reports/http-client-log`). The listing lets you **filter** the captured
requests, and each entry opens a **detail page** showing the full request and
response — method, URL, headers, and bodies.

Because each log entry is an entity, who can see it is governed by Drupal's entity
access system rather than a single flat permission. Grant that access only to people
who are allowed to see credentials and payload data (see below).

## Privacy and retention — the important part

A request log is the most sensitive log a Drupal site can keep. Treat these as
requirements, not suggestions:

- **Assume every entry contains secrets.** Outbound requests carry `Authorization`
  headers, API keys, and bearer tokens; their bodies (and the responses) carry
  whatever is being synchronized — often personal or financial data.
- **Redact rather than store whole**, where the module lets you, or accept that the
  log needs the same protection as the credentials inside it. It is copied into
  every database backup.
- **Restrict who can view the log** to trusted administrators only.
- **Set a retention limit / prune old entries.** With no expiry, a busy integration
  will grow this into the largest table in your database.
- **Keep it off production** except for short, deliberate investigations.

## Save

Save the settings form after any change. Logging behavior takes effect for
subsequent outbound requests.
