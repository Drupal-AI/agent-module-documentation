# Configuration

Vitals works as soon as it is enabled — a token is generated on install and all
four built-in checks are on by default. The settings form is where you copy the
token, rotate it, decide how unauthorised requests are answered, and trim which
checks are exposed.

## Open the settings form

1. Log in as a user with the **Administer vitals** permission.
2. Go to **Configuration → Web services → Vitals**, or navigate directly to
   `/admin/config/services/vitals`.

## The settings, field by field

- **The current token and endpoint URL** — the form shows the live endpoint URL
  with the current token filled in (`/vitals/<token>`). This is the URL you give
  your monitoring service.
- **Copy Current Token** — a convenience button that copies the token to your
  clipboard.
- **Generate New Token** — rotates the secret. Use this if the token leaks or a
  monitoring credential is compromised. **Rotating invalidates every existing
  client** — anything polling the old URL immediately starts failing, so update
  your monitors right after.
- **Unauthorized Action** (`vitals_unauthorized_action`, default **404**) —
  choose what a wrong or missing token returns. *404 – Not Found* hides the fact
  that the endpoint exists at all; *403 – Forbidden* tells the caller the
  resource is there but access was denied.
- **Enabled Vitals Checks** (`vitals_enabled_plugins`) — checkboxes for each
  available check. Only ticked checks appear in the JSON. The built-in ones are:
  - **CMS version** (`cms_version`) — the Drupal core version string.
  - **PHP version** (`php_version`) — the running PHP version.
  - **Themes** (`themes`) — the default and admin theme machine names.
  - **Updates** (`updates`) — pending updates and, separately, security updates
    (from core's Update module).

  Enable only the checks you actually need — for example, just *Updates* — to
  keep the exposed payload minimal.

Click **Save configuration** to store your choices.

## How the endpoint behaves

- On each request Vitals runs a flood check (10 attempts per IP per hour). Go
  over that and the request is refused just like a bad token.
- The URL token is compared to the stored one with a timing-safe comparison, so
  the endpoint does not leak how close a guess was.
- On success it returns a JSON object keyed by check id, e.g.
  `{ "cms_version": "…", "php_version": "…", "themes": {…}, "updates": {…} }`.
- The `updates` block splits results into `pending_updates` and
  `security_updates`, which is what you'd feed into an alerting pipeline.

## Adding your own health check

Developers can expose an application-specific metric by writing a `vitals_check`
plugin — see the agent docs at
[`agent/plugins/vitals_check.md`](../agent/plugins/vitals_check.md). After
adding one and clearing caches, tick it on this form so it is included in the
payload.
