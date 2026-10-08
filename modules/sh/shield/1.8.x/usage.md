Shield puts the whole site behind a single HTTP Basic Authentication prompt (a "walled garden"), so nobody can view it without a shared username/password — ideal for protecting dev, staging and pre-launch sites.

---

Shield registers an HTTP middleware (priority 250, before page caching) that intercepts every main request and, when enabled, returns a 401 with a `WWW-Authenticate` header unless the visitor supplies the configured Basic Auth credentials. This is distinct from Drupal's own login: it gates the entire application, including anonymous pages, before Drupal renders anything. Credentials come from one of three providers — plain config (`shield`), a Key entity holding the password (`key`), or a Key entity holding both username and password (`multikey`) — so secrets can be kept out of exported configuration. A greeting string is shown in the browser's auth dialog. Several exceptions let you poke holes in the shield: allow CLI (drush) access, allowlist IPs or IP ranges, allow specific HTTP methods (e.g. OPTIONS for CORS), allow whole domains (front-office public, back-office protected), and include- or exclude-mode path matching so you can protect only certain paths or leave certain paths open. A debug header (`X-Shield-Status`) reports why the shield did or did not prompt (disabled, skipped cli/path/ip/domain/http method, authenticated, pending). Settings live in `shield.settings` and are edited at Admin → Configuration → System → Shield; a migration is provided to bring D7 settings across.

---

- Password-protect a staging or QA site with a shared username/password.
- Hide a pre-launch site from the public and search engines behind Basic Auth.
- Keep a dev environment private without per-user Drupal accounts.
- Prevent indexing of a copied production database on a non-production URL.
- Allow drush/CLI to keep working while the web front end is shielded.
- Allowlist the office or VPN IP range so trusted users skip the prompt.
- Allow OPTIONS requests through so CORS preflight works while shielding the rest.
- Expose only the public front-office domain while protecting the back-office domain.
- Protect only specific paths (include mode), e.g. a not-yet-launched section.
- Leave specific paths open (exclude mode), e.g. a webhook or health-check endpoint.
- Store the shield password in a Key entity so it never lands in exported config.
- Store both username and password in a single multi-value Key.
- Show a custom greeting in the browser's Basic Auth dialog.
- Diagnose why the prompt appears (or not) via the `X-Shield-Status` debug header.
- Gate anonymous access to an intranet built on Drupal.
- Temporarily lock down a live site during maintenance or an incident.
- Protect a client demo site with a simple credential you can share verbally.
- Keep API/webhook endpoints reachable by allowlisting their paths or HTTP methods.
- Avoid serving cached pages to unauthenticated visitors (middleware runs before page cache).
- Unset conflicting Basic Auth headers so Drupal's own basic_auth still works behind the shield.
- Migrate existing D7 Shield settings during an upgrade.
- Allow a monitoring service through by its IP while shielding everyone else.
