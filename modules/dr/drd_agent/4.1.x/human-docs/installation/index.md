<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **PHP 8.1 or newer**.
- A running **Drupal Remote Dashboard (DRD)** instance elsewhere — the agent is the
  remote end of that dashboard, so it is only useful once you have a DRD portal to
  connect it to.
- No third-party PHP libraries are required.

## Suggested companion modules

DRD Agent works on its own, but it can surface extra data to the dashboard if you
also install:

- **Monitoring** (`drupal/monitoring`) — exposes site-monitoring sensors.
- **Security Review** (`drupal/security_review`) — surfaces security/config review
  results.
- **Hacked!** (`drupal/hacked`) — detects whether project code differs from the
  original on drupal.org.

## Install with Composer

From the project root:

```bash
composer require drupal/drd_agent -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/drd_agent -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en drd_agent -y
```

After enabling, you authorize your DRD dashboard to control the site — see
[Configuration](../configuration/index.md).

This module has no submodules.
