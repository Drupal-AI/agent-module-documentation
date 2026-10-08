# Drush Firewall — manual setup guide

**Drush Firewall** (`drush_firewall`) is a defensive operations tool that protects
your environments against running the wrong Drush command at the wrong time. It
lets you block specific commands outright, block certain commands only on
production, and restrict which commands may run while a site is in maintenance
mode — for example during a deployment. That last case is genuinely useful:
Drupal's core cron task still fires while a site is in maintenance mode, and this
module gives you a way to keep unwanted commands from running during a deploy.

There is no admin form. You configure it entirely through `$settings[]` entries,
which is deliberate: this kind of guardrail belongs in per-environment settings
files so that "never run this on production" travels with the environment
definition rather than living in the database. Global settings work too. It
supports Drupal 10.2+ and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and (for non-bootstrapping commands) register it with Drush.

There is **no admin configuration page** for this module — you configure it in
`settings.php`, described under "How to configure it" below.

## How to configure it

Add the settings you need to `settings.php` (ideally a per-environment settings
file). Each is an array of command names:

```php
// Commands that are never allowed to run in this environment:
$settings['drush_firewall_denied'] = [];

// Commands denied when the target alias is "prod":
$settings['drush_firewall_production_denied'] = [];

// The only commands allowed while the site is in maintenance mode
// (everything else, except a few necessary internal commands, is denied):
$settings['drush_firewall_maintenance_allowed'] = [];
```

- **`drush_firewall_denied`** — a hard blocklist; these commands will never run in
  this environment.
- **`drush_firewall_production_denied`** — commands blocked specifically when the
  target Drush alias is `prod`, so you can forbid destructive commands on
  production while allowing them elsewhere.
- **`drush_firewall_maintenance_allowed`** — an allowlist that takes over while the
  site is in maintenance mode: only these commands (plus a few essential internal
  ones) run, and everything else is denied. This is what keeps stray commands from
  firing during a deployment.

### Protecting commands that do not bootstrap Drupal

Some Drush commands (such as `sql:sync`) do not fully bootstrap Drupal, so the
module cannot hook into them the normal way. To cover those, register the module
in your `drush/drush.yml` so Drush loads it early. For example, if your docroot is
at `/var/www/docroot/`:

```yaml
drush:
  include:
    - '/var/www/docroot/modules/contrib/drush_firewall'
```

### Bypassing the firewall on purpose

If you occasionally need to run a command the firewall would otherwise block, pass
`--disable-firewall` on that command to turn off all checks for that single run.
