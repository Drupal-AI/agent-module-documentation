# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- The **Honeypot** module (`honeypot`) installed and enabled — Honeycronpot builds
  on it and cannot work without it.
- **Cron** running reliably on your site — the field‑name rotation happens on cron
  runs, so if cron never runs, the name never changes.

There are no additional third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/honeycronpot -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Honeypot (if it
isn't already present) and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/honeycronpot -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable Honeypot first (if it isn't already), then Honeycronpot:

```bash
drush en honeypot honeycronpot -y
```

## Make sure cron runs

The rotation relies entirely on cron. Confirm cron is scheduled and running — for
a quick manual run:

```bash
drush cron
```

On production, use a real system cron (or your host's scheduler) rather than
Drupal's automated cron, so rotations happen on a predictable cadence.

## Verify it worked

After enabling and running cron at least once, check **Reports → Recent log
messages** (`/admin/reports/dblog`) — the module records when it changes the
honeypot field name, so a log entry there confirms the rotation is happening.
