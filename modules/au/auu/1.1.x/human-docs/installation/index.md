# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- The **Login Security** module (`login_security`) — this is a hard dependency.
  Auto unblock users extends Login Security and does nothing on its own; make sure
  Login Security is installed, enabled, and configured with sensible block
  thresholds.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/auu -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Login Security and
any other shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/auu -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en auu -y
```

Enabling `auu` also requires `login_security` to be enabled (Drupal handles this
as a dependency). Once both are on, head to the Login Security settings form to
turn on automatic unblocking — see [Configuration](../configuration/index.md).
