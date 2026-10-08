# Configuration

All of Raven's settings live in the single `raven.settings` config object and are
edited in the **Raven** section of core's Logging form. Nothing is sent to Sentry
until you provide a DSN **and** enable at least one handler or log level.

## Open the settings

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → Development → Logging and errors**
   (`/admin/config/development/logging`) and scroll to the **Raven** section.

You can also read and write everything from the command line, e.g.
`drush cget raven.settings` and
`drush cset raven.settings log_levels.error true -y`.

## Connect to Sentry

- **Sentry DSN (PHP)** (`client_key`) — the DSN Raven uses to send server-side
  (PHP) events.
- **Public DSN (JavaScript)** (`public_dsn`) — the DSN for the browser JavaScript
  SDK, used when you enable the JavaScript error handler or browser tracing.
- **Environment** (`environment`) and **Release** (`release`) — optional tags (for
  example `production` and a version string) attached to every event.

## Choose what to capture

- **Log levels** (`log_levels`) — tick which PSR log levels (emergency … debug) are
  sent to Sentry as **error events**. By default none are enabled.
- **Fatal error handler** (`fatal_error_handler`) — capture fatal PHP errors that
  Drupal can't normally log (e.g. memory-limit exceeded).
- **JavaScript error handler** (`javascript_error_handler`) — load the Sentry
  browser SDK to capture front-end exceptions.
- **Drush error handler** (`drush_error_handler`) — capture exceptions thrown by
  Drush commands.
- **Structured logs** — enable `enable_logs` (the master switch) and pick levels in
  `logs_log_levels` to send lightweight structured logs (no stack traces) at the
  end of the request.
- **Ignored channels / messages** (`ignored_channels`, `ignored_messages`) — never
  send events from certain logger channels or matching certain message patterns.

## Performance tracing (optional)

- **Request tracing** (`request_tracing`) — create a Sentry transaction per
  request/response.
- **Sample rates** — `traces_sample_rate` (backend) and
  `browser_traces_sample_rate` (browser), each 0–1, control what fraction of
  requests are traced.
- **Spans** — add spans for database queries (`database_tracing`), rendered Twig
  templates (`twig_tracing`), Drush commands (`drush_tracing`), and 404s
  (`404_tracing`).
- **Profiling** — `profiles_sample_rate` enables CPU flame graphs (needs the
  Excimer extension).

## Privacy-related options

Several options attach potentially sensitive data to events and are **off by
default** — enable them only if you understand the privacy implications:
**send user data** (`send_user_data`), **capture user IP** (`capture_user_ip`),
and **send request body** (`send_request_body`). There are also release-health
(`auto_session_tracking`), user-feedback dialog (`show_report_dialog`), and cron
monitoring (`cron_monitor_id`) options.

## Keep the DSN out of configuration

Because a DSN is a credential, Raven can read it (and the environment/release tags)
from environment variables, which **override** the stored config so your DSN never
lands in an exported configuration file:

| Environment variable | Overrides |
|----------------------|-----------|
| `SENTRY_DSN` | the PHP DSN (`client_key`) and the JavaScript DSN (`public_dsn`) |
| `SENTRY_ENVIRONMENT` | `environment` |
| `SENTRY_RELEASE` | `release` |

On DDEV you can set the variable with DDEV's dotenv support and restart so it's
available in the container:

```bash
ddev dotenv set .ddev/.env --sentry-dsn='https://examplePublicKey@o0.ingest.sentry.io/0'
ddev restart
```

(Never commit `.ddev/.env`.) The `SENTRY_DSN` value will then win over anything in
`raven.settings`.

## CSP reporting

Raven provides a Sentry reporting handler for the **CSP** module — set CSP's
reporting handler to "Sentry" to route Content Security Policy violation reports to
your project. Alternatively, with the **Security Kit** module installed, enable
`seckit_set_report_uri` to send CSP reports to Sentry directly from the browser.

## Save

Save the Logging form. A quick way to confirm everything is wired up is to send a
test event via the module's Drush command and check that it appears in your Sentry
project.
