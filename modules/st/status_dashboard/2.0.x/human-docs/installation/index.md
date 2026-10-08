# Installation

## Requirements

Status dashboard needs:

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Views** (`views`) module, which Drupal enables as a dependency.
- On **each site you want to monitor**, the companion **Status Dashboard Client**
  module (`drupal/status_dashboard_client`).

There are no third-party Composer or PHP library requirements.

## Install with Composer

On the central (dashboard) site, from the project root:

```bash
composer require drupal/status_dashboard -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/status_dashboard -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en status_dashboard -y
```

## Install the client module on monitored sites

The dashboard cannot see a site until that site runs the client module. On each
site you want to monitor:

```bash
composer require drupal/status_dashboard_client
drush en status_dashboard_client -y
```

Then configure the client's **secret** at
`/admin/config/development/status-dashboard-client` to match the secret you enter
for that site on the central dashboard (see
[Configuration](../configuration/index.md)).
