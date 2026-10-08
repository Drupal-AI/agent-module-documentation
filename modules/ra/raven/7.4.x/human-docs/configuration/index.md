# Configuration

All of Raven's settings live in one config object, `raven.settings`, which the
module injects into the bottom of core's **Logging and errors** form. There is no
separate Raven page. Two rules to keep in mind: **nothing is sent to Sentry until
you set a DSN**, and each category of data (error events, structured logs,
tracing) has its own switch that must also be turned on.

## Open the settings

1. Log in as an administrator (you need **Administer site configuration** — that
   permission also gates the "Send test message" buttons).
2. Go to **Configuration → Development → Logging and errors**
   (`/admin/config/development/logging`) and scroll to the Raven / Sentry section.

You can also read and write every setting with Drush, which is handy for
deployment:

```bash
drush cget raven.settings
drush cset raven.settings client_key 'https://examplePublicKey@o0.ingest.sentry.io/0' -y
```

## Connecting to Sentry

- **Client key (DSN)** (`client_key`) — the Sentry DSN used for PHP events. This
  is the one essential setting.
- **Public DSN** (`public_dsn`) — the DSN used by the browser JavaScript SDK.
- **Environment** (`environment`) — a tag such as `production` or `staging` so you
  can filter events in Sentry.
- **Release** (`release`) — a version tag for the deployed code.

You can supply these three from the environment instead, using `SENTRY_DSN`
(fills both DSNs), `SENTRY_ENVIRONMENT`, and `SENTRY_RELEASE`. Environment values
win over stored config, which is the recommended way to keep the DSN out of
exported configuration.

## Choosing what errors to send

- **Log levels** (`log_levels`) — tick the PSR severities (emergency, alert,
  critical, error, warning, notice, info, debug) you want forwarded to Sentry as
  **error events**. All are off by default, so pick, for example, error and above.
- **Fatal error handler** (`fatal_error_handler`) — capture fatal PHP errors such
  as memory‑limit‑exceeded. The related `fatal_error_handler_memory` reserves a
  little memory so the handler can still run when memory runs out.
- **JavaScript error handler** (`javascript_error_handler`) — load the Sentry
  browser SDK so client‑side JavaScript errors are captured. (Users' browsers
  only do this if they have the *send javascript errors to sentry* permission.)
- **Drush error handler** (`drush_error_handler`) — capture exceptions thrown by
  Drush commands.
- **Ignored channels** (`ignored_channels`) and **ignored messages**
  (`ignored_messages`) — logger channels and message patterns to never send, to
  cut noise.
- **Rate limit** (`rate_limit`) — the most events to send per request (0 =
  unlimited), to protect your Sentry quota on noisy code paths.

## Structured logs

- **Enable logs** (`enable_logs`) — the master switch for Sentry structured logs
  (lightweight, no stack trace).
- **Logs log levels** (`logs_log_levels`) — which severities are sent as
  structured logs (as opposed to full error events).

## Performance and distributed tracing

- **Request tracing** (`request_tracing`) — create a Sentry transaction for each
  request/response.
- **Backend traces sample rate** (`traces_sample_rate`) and **browser traces
  sample rate** (`browser_traces_sample_rate`) — the fraction of requests (0–1)
  sampled for performance tracing on the server and in the browser respectively.
- **Database tracing** (`database_tracing`, plus `database_tracing_args` to include
  query arguments) — add a span per database query to find slow ones.
- **Twig tracing** (`twig_tracing`) — add a span per Twig template to profile
  theming.
- **Drush tracing** (`drush_tracing`) and **404 tracing** (`404_tracing`) — trace
  Drush command execution and 404 responses.
- **Trace propagation targets** (`trace_propagation_targets_backend` /
  `_frontend`) — the hosts (and browser regexes) that receive `sentry-trace` and
  `baggage` headers for distributed tracing across services.
- **Profiling sample rate** (`profiles_sample_rate`) — CPU profiling flame graphs;
  requires the Excimer PHP extension.

## Privacy

- **Send user data** (`send_user_data`) — attach authenticated user details to
  events.
- **Capture user IP** (`capture_user_ip`) — attach the end user's IP address.
- **Send request body** (`send_request_body`) — attach the HTTP request body.

All three are off by default; enable them only if your privacy/compliance rules
allow it.

## Other useful switches

- **Tunnel** (`tunnel`) — relay browser Sentry events through `/raven/tunnel` so ad
  blockers don't drop them.
- **Cron monitor id** (`cron_monitor_id`) — a Sentry cron‑monitor slug to enable
  check‑in monitoring of your cron runs.
- **Modules** (`modules`) — attach the list of installed Composer packages to
  events for dependency context.
- **CSP reporting** — Raven provides a "Sentry" reporting handler for the CSP
  module; set CSP's handler to *Sentry* to route violation reports to your
  project. With Security Kit installed, `seckit_set_report_uri` sends CSP reports
  straight to Sentry from the browser.

After changing settings, rebuild caches with `drush cr`.

## A working example

Capture error‑and‑above as events, enable structured logs, and sample 25% of
backend traces with database spans:

```bash
drush cset raven.settings log_levels.error true -y
drush cset raven.settings log_levels.critical true -y
drush cset raven.settings enable_logs true -y
drush cset raven.settings logs_log_levels.error true -y
drush cset raven.settings request_tracing true -y
drush cset raven.settings traces_sample_rate 0.25 -y
drush cset raven.settings database_tracing true -y
drush cr
```

Then send a test event to confirm the connection:

```bash
drush raven:captureMessage "Hello from Raven"
```

## Permissions

Raven defines two permissions at **People → Permissions**, both about browser
activity:

- **Send javascript errors to sentry** — the user's browser loads the Sentry JS
  SDK and can capture/send JavaScript errors; also required to POST to the tunnel
  route.
- **Send performance traces to sentry** — the user's browser sends browser
  performance traces.

Grant them to the roles you want to monitor, for example:

```bash
drush role:perm:add anonymous 'send javascript errors to sentry'
```

(The "Send test message" buttons on the logging form instead require the core
*administer site configuration* permission.)
