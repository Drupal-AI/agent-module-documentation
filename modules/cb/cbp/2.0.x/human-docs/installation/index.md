# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Ban** module (`ban`), which CBP uses to block offending IPs. Drupal
  enables it automatically as a dependency.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/cbp -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/cbp -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en cbp -y
```

Enabling CBP also enables core's Ban module.

## After enabling

CBP protects the login flow immediately. Because it reports threats through a
**queue** processed by a background worker, make sure Drupal's **cron** runs on a
regular schedule (via a real system cron or an external scheduler) so queued
reports are sent and the crowd intelligence stays current.

Review and tune the detection **thresholds** so legitimate users sharing an IP
aren't caught alongside attackers — see [How to use it](../index.md#how-to-use-it)
in the main guide.

## Verify it worked

Confirm the module and core Ban are enabled under **Extend**
(`/admin/modules`). You can validate detection by making repeated failed login
attempts from a disposable test IP and confirming that the IP is banned once your
threshold is exceeded.
