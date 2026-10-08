<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Lagoon Logs is a near zero-configuration logging bridge that ships Drupal's log messages over UDP to the Logstash endpoint of the Lagoon hosting platform, formatted as Logstash JSON via Monolog.

---

The module registers a Drupal logger service (`logger.lagoon_logs`, tagged `logger`) built by `LagoonLogsLoggerFactory::create()` from the `config.factory` and `logger.log_message_parser` services. Every message written to Drupal's logging channel (`\Drupal::logger()` / watchdog) is passed to `LagoonLogsLogger::log()`, which builds a Monolog logger with a `SocketHandler` pointing at `udp://<host>:<port>`, formats the record with `LagoonLogsFormatter` (a `LogstashFormatter` subclass emitting `@timestamp`, `host`, `message`, `channel`, `level`, and extra fields such as `ip`, `request_uri`, `uid`, `link`), and sends it. Configuration lives in `lagoon_logs.settings` with four keys: `host` (default `application-logs.lagoon.svc`), `port` (default `5140`), `identifier` (default `drupal`), and `disable` (default `0`). The per-record system name is the "full identifier" — `LAGOON_PROJECT` and `LAGOON_GIT_SAFE_BRANCH` environment variables joined by a dash (falling back to `project_unset` / `safe_branch_unset`) — so logs from every project/branch are distinguishable in the aggregator. When `disable` is truthy the factory returns `FALSE` for the identifier and the logger short-circuits, sending nothing. The settings form (route `lagoon_logs.settings`, at `/admin/config/development/lagoon_logs`, gated by core `administer site configuration`) is primarily a troubleshooting page: it only lets you toggle `disable` and displays the current host/port/identifier read-only, because the defaults are meant to work unchanged inside Lagoon. RFC log levels are mapped to Monolog levels, and failures to reach the log target are swallowed so logging never breaks a request.

---

- Ship Drupal watchdog logs to Lagoon's central Logstash/ELK stack with essentially no setup.
- Aggregate logs from many Lagoon projects and branches, disambiguated by the LAGOON_PROJECT/branch identifier.
- Forward structured JSON logs (Logstash format) rather than plain text for better searchability.
- Send logs over UDP to `application-logs.lagoon.svc:5140` by default on the Lagoon platform.
- Override the Logstash host/port when running a custom or non-default log collector.
- Temporarily disable log shipping (e.g. during noisy maintenance) via the `disable` toggle.
- Include request context (IP, request URI, uid, referring link) in each shipped log record.
- Distinguish environments (prod vs a feature branch) automatically using LAGOON_GIT_SAFE_BRANCH.
- Set a custom leading identifier to tag this application's logs in the aggregator.
- Keep the site resilient — unreachable log targets are caught and never surface as request errors.
- Route logs to a self-hosted Logstash instance by pointing host/port at it.
- Monitor error/warning volume centrally across a fleet of Lagoon-hosted Drupal sites.
- Use the settings page to verify the effective host/port/identifier when debugging missing logs.
- Preserve Drupal's log channel names as the Logstash `channel`/`type` for filtering.
- Correlate logs by severity using the RFC→Monolog level mapping (e.g. ERROR=400, WARNING=300).
- Feed logs into downstream alerting built on the Logstash pipeline.
- Deploy the same codebase to any Lagoon environment and have logging "just work" per environment.
- Turn logging back on centrally by clearing the `disable` flag in configuration.
- Export `lagoon_logs.settings` with your site config so log routing is part of your deployment.
- Replace ad-hoc syslog configuration with a maintained Monolog-based UDP shipper.
