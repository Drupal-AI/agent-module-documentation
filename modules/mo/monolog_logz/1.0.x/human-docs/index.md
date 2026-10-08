# Monolog-Logz — manual setup guide

**Monolog-Logz** (`monolog_logz`) is a small "glue" module that ships your
Drupal logs to **[Logz.io](https://logz.io/)** — a hosted ELK/observability
platform for centralised log search, dashboards, and alerting. It takes the
shipping handler from the `logzio-monolog` PHP library and exposes it to the
[Monolog](https://www.drupal.org/project/monolog) module as a service you can
plug into your log pipeline, configured through Drupal's own configuration
system rather than hard-coded in a services file.

The problem it solves is a practical one: the `logzio-monolog` library expects
PHP enumerations as constructor arguments, which Drupal's YAML service parser
cannot supply directly. Monolog-Logz bridges that gap by registering a
`monolog.handler.logz` service and reading its settings (your Logz.io token,
log level, and region host) from a `monolog_logz.settings` configuration item —
so you can keep the token in `settings.php`, an environment variable, or a
secrets manager instead of committing it to a `*.services.yml` file.

Like the Monolog module itself, this module has **no visible user interface**.
It is configured entirely in code/configuration: you add your Logz.io details
to `settings.php`, and you tell Monolog to actually *use* the `logz` handler in
a `monolog.services.yml` (or equivalent) file. It depends on the Monolog module
and requires **PHP 8.2**.

As with any external log shipping, mind the security basics: **store your
Logz.io shipping token as a secret**, and remember that log content — request
data, errors, and potentially sensitive details — is transmitted to a
third-party service. Scrub or avoid logging sensitive data.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module (and the Monolog
   library) with Composer and enable it.
2. [Configuration](configuration/index.md) — add your Logz.io token, level, and
   host, and wire the handler into Monolog.

## Where it lives in the admin menu

There is no admin page. All setup happens in `settings.php` and your Monolog
services file — see [Configuration](configuration/index.md).
