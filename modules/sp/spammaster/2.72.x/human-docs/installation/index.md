# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- No other contrib modules and no third‑party PHP libraries.
- **Outbound HTTPS access to `https://www.spammaster.org`** from your server. The
  module contacts spammaster.org on install to create a license and daily (via
  cron) to sync threat lists, so this must not be firewalled off.

## Install with Composer

From the project root:

```bash
composer require drupal/spammaster -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/spammaster -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en spammaster -y
```

On enable, Spam Master:

- generates a random license key and a rotating database-protection hash,
- contacts spammaster.org to **auto-create a free license** (no manual signup),
- creates its own database tables for threats, logs, and the whitelist,
- turns on the firewall and honeypot with sensible defaults and sets the site to
  production mode.

Make sure **cron runs regularly** on your site — the daily threat-list sync and the
scheduled log cleanup both run on cron.

Next, review and tune the protection settings on the
[Configuration](../configuration/index.md) page.
