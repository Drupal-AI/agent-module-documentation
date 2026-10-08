# Installation

## Requirements

- **Drupal 8, 9, 10 or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- The **EU Cookie Compliance** module (`eu_cookie_compliance`) — installed,
  enabled and configured with a working consent banner.
- The **Matomo** module (`matomo`) — installed, enabled and configured with your
  Matomo tracking details.

Both are hard dependencies. This module only supplies the consent wiring between
them, so both must be set up and working for it to do anything. There are no
third-party Composer or PHP library requirements of its own.

## Install with Composer

From the project root:

```bash
composer require drupal/eu_cookie_compliance_matomo -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the dependencies and
update any shared ones as needed. (You will still need to install and configure the
EU Cookie Compliance and Matomo modules if you haven't already.)

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/eu_cookie_compliance_matomo -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en eu_cookie_compliance_matomo -y
```

## Next step

If you use EU Cookie Compliance in **opt-in with categories** mode, choose which
categories must be agreed before Matomo gets consent — see
[Configuration](../configuration/index.md). In plain opt-in mode, the wiring works
as soon as the module is enabled.
