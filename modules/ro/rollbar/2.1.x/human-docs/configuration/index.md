# Configuration

Rollbar is configured on one settings form. Everything below lives there.

## Open the settings form

1. Log in as a user with the **administer rollbar** permission.
2. Go to **Configuration → Services → Rollbar**, or navigate directly to
   `/admin/config/services/rollbar`.

## The master switch and identity

- **Enabled** — the master switch for *both* server and client reporting. It's off by
  default, and while it's off nothing is sent to Rollbar. Turn it on once your tokens
  and environment are set.
- **Server access token** — the token Rollbar issued with the `post_server_item`
  scope. Used for the log messages forwarded from PHP. Server‑side reporting only
  initializes when this token *and* an environment are present.
- **Client (frontend) access token** — the token with the `post_client_item` scope.
  This one is emitted into the browser for the JavaScript reporter.
- **Environment** — a label (default `production`) attached to every report so you can
  separate streams like `production` and `staging` in Rollbar. It's required for the
  server side to start reporting.

> If you followed the recommended setup in [Installation](../installation/index.md),
> the two tokens come from environment variables via `settings.php` and you can leave
> the token fields blank here.

## What gets reported, server‑side

- **Log levels** — a checkbox set of the RFC severities (Emergency, Alert, Critical,
  Error, Warning, Notice, Info, Debug). Only the levels you tick are forwarded.
  **Leaving this empty means no server messages are sent, even when the module is
  enabled** — so pick at least the high severities (Emergency through Error is a good
  starting point).
- **Channels to exclude** — a semicolon‑separated list of logger channels to leave
  out (for example `php;cron`), so noisy sources don't flood your Rollbar project.

## What gets reported, client‑side

- **Capture uncaught errors** — report uncaught JavaScript errors from the browser
  (on by default).
- **Capture unhandled promise rejections** — also report unhandled promise
  rejections (off by default).
- **Host allow‑list** — a comma‑separated list of hosts; when set, the browser only
  reports errors that occur on those domains. Useful to avoid noise from third‑party
  scripts or other origins.
- **Ignored messages** — a list of specific client‑side error messages to suppress.
- **Rollbar JS URL** — the URL of the Rollbar JavaScript library. It defaults to a
  Rollbar CDN build; change it only if you want to pin a version or self‑host it.

## Privacy and request filtering

- **Person tracking** — controls whether the reporting user is identified. **Off**
  sends no user data; **ID** attaches only the user's numeric ID; **Full** attaches
  the ID *plus* username and email. The form flags Full as a GDPR consideration —
  choose it only if your privacy policy allows it.
- **Scrub fields** — a list of field names whose values are replaced with asterisks
  before a report leaves your server, so secrets don't end up in Rollbar. It comes
  pre‑filled with sensible defaults (`password`, `secret`, `auth_token`,
  `csrf_token`, and similar); add your own field names as needed.
- **Ignored headers** — a list of `Header: value` lines. When an incoming request
  carries a matching header, reporting is disabled for that request — handy for
  silencing monitoring or uptime bots.

## Save and verify

Click **Save configuration**. Then trigger a test error (a deliberate PHP notice or a
JavaScript error) and confirm it appears in your Rollbar project's dashboard, tagged
with the environment you set. If nothing arrives, re‑check that **Enabled** is on, a
server token and environment are present, and at least one **log level** is ticked.

Developers can also adjust the client‑side settings from a custom module via
`hook_rollbar_settings_alter()`.
