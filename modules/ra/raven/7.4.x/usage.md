Raven integrates Drupal with Sentry, the open-source application monitoring and error-tracking platform, capturing exceptions, PHP/JavaScript errors, Drush errors and log messages as Sentry events and structured logs.

---

Raven registers a Drupal logger (`logger.raven`) that forwards selected log-level messages, uncaught exceptions and fatal PHP errors to a Sentry project identified by a DSN (client key). It also loads the Sentry JavaScript SDK to capture browser errors, and adds handlers for fatal errors and Drush command exceptions. Beyond errors, it integrates with Sentry performance tracing and distributed tracing: when a browser or backend sample rate is set above zero it creates a transaction per request plus spans for HTTP-client calls, database queries and Twig templates, and propagates `sentry-trace`/`baggage` headers to configured hosts. All configuration lives in the single `raven.settings` config object, surfaced on the core Logging and errors form (`/admin/config/development/logging`) via a form alter — the module has no page of its own. The Sentry DSN, environment and release can alternatively be supplied through the `SENTRY_DSN`, `SENTRY_ENVIRONMENT` and `SENTRY_RELEASE` environment variables, which override the stored config. It ships Drush commands (`raven:captureMessage`, `raven:captureLog`), optional Sentry structured-logs support, cron check-in monitoring, a CSP reporting handler for the CSP module, Security Kit CSP-report tunnelling, and a `/raven/tunnel` route to relay browser events past ad blockers. Developers customize Sentry client options through the `OptionsAlter` and `AttributesAlter` events and standard Sentry `before_send`/`before_breadcrumb` callbacks.

---

- Send uncaught exceptions and fatal PHP errors (e.g. memory-limit-exceeded) to Sentry with full stack traces.
- Forward Drupal watchdog log messages of chosen severities (error, warning, notice, …) to Sentry as issues.
- Capture browser JavaScript errors via the bundled Sentry JavaScript SDK for users with the right permission.
- Report exceptions thrown by Drush commands using the Drush error handler.
- Send a quick test event to verify configuration with `drush raven:captureMessage`.
- Emit lightweight Sentry structured logs (no stack trace) with `drush raven:captureLog` or the logs log-levels setting.
- Configure the Sentry DSN per-environment via the `SENTRY_DSN` environment variable instead of stored config.
- Tag events with an environment name (`SENTRY_ENVIRONMENT`) and release version (`SENTRY_RELEASE`) for filtering in Sentry.
- Enable backend performance tracing by setting a traces sample rate to record request/response transactions.
- Enable browser performance tracing with a separate browser traces sample rate.
- Add spans for every database query to find slow queries (database tracing).
- Add spans for Twig template rendering to profile theming performance.
- Trace Drush command execution as Sentry transactions (Drush tracing).
- Enable distributed tracing across services by listing trace-propagation target hosts.
- Rate-limit the number of events sent per request to protect the Sentry quota on noisy code paths.
- Ignore specific logger channels or log-message patterns so they are never sent to Sentry.
- Suppress or transform events using an `OptionsAlter` subscriber with a `before_send` callback.
- Ignore chosen exception classes with the Sentry `ignore_exceptions` option.
- Collapse or expose stack frames from certain paths via `in_app_exclude` / `in_app_include`.
- Monitor cron reliability with Sentry cron check-ins by setting a cron monitor slug.
- Enable CPU profiling flame graphs (requires the Excimer PHP extension) via a profiling sample rate.
- Send Content-Security-Policy violation reports to Sentry through the CSP module's "Sentry" reporting handler.
- Forward Security Kit CSP reports directly to Sentry, bypassing the Drupal logging system.
- Send Monitoring module sensor status changes to Sentry.
- Tunnel browser Sentry requests through `/raven/tunnel` to evade ad blockers.
- Attach the list of installed Composer packages to events for dependency context.
- Send logs to Sentry through the Monolog module using the `drupal.raven` handler target.
- Control whether end-user IP addresses and user data are attached to events for privacy compliance.
