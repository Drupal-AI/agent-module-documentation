# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- Core's **Ban** module (`ban`) — this is the one dependency; Drupal enables it
  automatically when you turn on Auto Unban. (Ban is not enabled by default in a
  standard install, so make sure it's available.)

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/auto_unban -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/auto_unban -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en auto_unban -y
```

## What enabling does to the ban table

Auto Unban adds two columns (`expires` and `attempts`) to core's `ban_ip` table so it
can track when each ban lapses and how many times an IP has been banned. To protect
you, **every ban that already exists at install time is set to a far-future expiry**
— so your current bans stay effectively permanent and nothing is unbanned by
surprise. New bans made after this point follow the time-limited policy (see the
[behavior note in the overview](../index.md)).

Uninstalling cleans up after itself: it deletes any already-expired ban rows (so core
Ban won't resurrect them) and drops the two extra columns.

## Right after enabling

Head to *Configuration → System → Auto Unban* to set your base ban window — see
[Configuration](../configuration/index.md). Access uses the core **Administer site
configuration** permission, which administrators already have.

This module has no submodules.
