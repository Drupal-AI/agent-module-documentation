# Monolog — manual setup guide

**Monolog** (`monolog`) integrates Drupal with the popular **Monolog** PHP logging
library by Jordi Boggiano. It gives you a far more powerful and flexible logging
setup than Drupal's built-in database log: configurable log levels, a large choice
of **handlers** (where logs go — rotating files, syslog, stdout, Slack, and many
more), **formatters** (how each line looks — plain line, JSON, HTML, GELF…), and
**processors** (extra context added to each record — current user, request URI,
IP, memory usage…). It has full watchdog integration, so it works with core and
contributed modules out of the box.

The most important thing to know: **Monolog has no admin UI and no config
entities**. You configure it entirely in a YAML services file plus a couple of
container parameters, then rebuild the container. That makes it a developer- and
ops-oriented module rather than a click-through one — there is no settings page in
the admin menu, and therefore no separate configuration guide here; the setup
steps are below.

Also worth knowing: enabling Monolog **overrides Drupal's core logging
behavior**. If you still want core loggers such as the database log (Watchdog) to
receive messages, you must add them to your Monolog configuration explicitly (see
the "Log to database" topic in the module's README). Monolog 3.x requires **PHP
8.1+** and Drupal 10.1 or newer, and depends on the `monolog/monolog` library
(installed via Composer). It ships **no submodules**.

This guide is written for a **human** setting things up — but in Monolog's case
that means editing YAML, not clicking through admin pages. For terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and the Monolog
   library with Composer and enable it.

There is **no configuration page** for this module. Configuration is done in a
services YAML file, summarized under "How to configure it" below.

## Where it lives in the admin menu

Nowhere — Monolog adds no admin page and no settings form (`configure` is null).
All configuration happens in code/YAML.

## How to configure it

Monolog reads its configuration from a services YAML file that you create and
register in `settings.php`. A typical starting point:

1. Create `sites/default/monolog.services.yml`.
2. Register it in `settings.php`:

   ```php
   $settings['container_yamls'][] = 'sites/default/monolog.services.yml';
   ```

3. Rebuild the container after any change: `drush cr`.

Inside that file you set three main things:

- **Channel handlers** (`monolog.channel_handlers`) — map each log channel to one
  or more handlers, with a required `default` fallback. For example, send the
  `php` channel to its own rotating file and everything else to syslog.
- **Handlers** — services named `monolog.handler.<name>` whose class is any
  Monolog handler (rotating file, stream to `php://stdout`, Slack, and so on).
  The module predefines several (`syslog`, `error_log`, `browser_console`,
  `null`, and more) and you can declare your own.
- **Formatters and processors** — services named `monolog.formatter.<name>` and
  `monolog.processor.<name>`, referenced by name, to control the shape of each log
  line and the context attached to it.

A small example that sends everything to a rotating file:

```yaml
parameters:
  monolog.channel_handlers:
    default: ['rotating_file']
services:
  monolog.handler.rotating_file:
    class: Monolog\Handler\RotatingFileHandler
    arguments: ['private://logs/debug.log', 10, 'DEBUG']  # path, maxFiles, min level
    shared: false
```

To keep sending log messages to Drupal's database log, add the `drupal.dblog`
handler to the relevant channels — see the module's README "Log to database"
section. The full catalogue of predefined handlers, formatters, and processors
(including web-vs-CLI conditional handlers) is documented in the
[`agent/`](../agent/start.md) docs.
