# Monolog — manual setup guide

**Monolog** (`monolog`) replaces Drupal's built‑in logger with the popular
[Monolog](https://github.com/Seldaek/monolog) PHP logging library. Once enabled,
every `\Drupal::logger($channel)` call in Drupal and its contrib modules is backed
by Monolog, which means you can route log messages wherever you like — to daily
rotating files, the operating system's syslog, the web server error log, a Slack
channel, an email address, stdout for a container platform, or structured JSON for
a log aggregator like Graylog or Google Cloud Logging.

The way it works is that the module's service provider overrides Drupal's core
`logger.factory` service. It does not add anything to the admin interface. Instead,
you describe your logging setup — which channels go to which destinations, in which
format, enriched with which extra metadata — in a **services YAML file** and a
small snippet in `settings.php`. This is very much a developer‑oriented module: if
you are comfortable editing `settings.php` and a YAML file and running `drush cr`,
you'll be right at home; if you were hoping for a point‑and‑click settings page,
there isn't one.

Monolog organises logging around three ideas. **Handlers** decide *where* a message
goes (a file, syslog, Slack, mail, and so on). **Formatters** decide *how* it looks
(a one‑line string, JSON, HTML). **Processors** decide *what extra information* is
attached to each record (the current user, request URI, IP address, a backtrace,
memory usage, and more). You map each log *channel* — `php`, `cron`, `default`, or
any channel a module logs to — onto one or more handlers, and optionally attach
formatters and processors. Because it committs to a YAML file, the exact same
logging configuration travels with your codebase across every environment.

This guide is written for a **human** setting the module up by hand. If you want
terse, token‑cheap references for an AI coding agent — including the full list of
built‑in handlers, formatters, and processors — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer (it
   pulls in the `monolog/monolog` library) and enable it.

## Where it lives in the admin menu

Nowhere — Monolog has **no admin UI and no configuration entities**. There is no
settings page to visit. All configuration is done by editing files on disk, as
described below.

## How to use it

The short version:

1. Enable the module (see [Installation](installation/index.md)). On its own, with
   no extra configuration, Monolog sends the `default` channel to **syslog** and the
   `php` channel to the **web server error log**.
2. To change that, create a services file — the conventional location is
   `sites/default/monolog.services.yml` — and register it in `settings.php`:

   ```php
   $settings['container_yamls'][] = 'sites/default/monolog.services.yml';
   ```

3. In that YAML file, set the `monolog.channel_handlers` parameter to map each
   channel to one or more handlers, declare those handlers as services under the
   `monolog.handler.*` namespace (their class is any Monolog handler such as
   `RotatingFileHandler`, `SyslogHandler`, `StreamHandler`, or `SlackHandler`), and
   optionally attach formatters and processors.
4. Run `drush cr` (rebuild the container) after every change so Drupal picks up the
   new services.

A minimal example that logs everything to a daily rotating file in the private
filesystem, and sends the `php` channel to its own separate file:

```yaml
parameters:
  monolog.channel_handlers:
    php: ['rotating_file_php']
    default: ['rotating_file']
services:
  monolog.handler.rotating_file:
    class: Monolog\Handler\RotatingFileHandler
    arguments: ['private://logs/debug.log', 10, 'DEBUG']
    shared: false
  monolog.handler.rotating_file_php:
    class: Monolog\Handler\RotatingFileHandler
    arguments: ['private://logs/php.log', 10, 'DEBUG']
    shared: false
```

If you want to keep writing to Drupal's familiar Watchdog/database log at the same
time, add the built‑in `drupal.dblog` handler to a channel's handler list. For the
complete catalogue of handlers, formatters, processors, and the more advanced
web‑versus‑CLI conditional handling, see the
[agent configuration reference](../agent/configure/monolog.md).
