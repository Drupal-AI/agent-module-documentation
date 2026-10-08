# Installation

## Requirements

- **Drupal 9, 10.3, or 11** (`core_version_requirement: ^9 || ^10.3 || ^11`).
- The contributed **Reroute Email** module (`reroute_email`, 2.3.0 or newer) — this
  companion builds directly on it, and Composer pulls it in automatically.

There are no third‑party Composer or PHP library requirements.

> **Not covered by a security advisory.** This module is not covered by Drupal's
> security advisory policy. That is a reason to keep it — and rerouting itself — to
> non-production environments, which is where it belongs anyway.

## Install with Composer

From the project root:

```bash
composer require drupal/reroute_email_be -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Reroute Email
dependency and update any shared packages as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/reroute_email_be -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en reroute_email_be -y
```

Enabling this module also enables **Reroute Email** if it is not already on.

## Verify it worked

Log in as an administrator and go to **Configuration → Development → Better
Experience for Reroute emails** (`/admin/config/development/reroute_email_be`). You
should see the enhanced settings form. Next, work through
[Configuration](../configuration/index.md) to set the destination address, assign
the governance permissions and roles, and place the status block.
