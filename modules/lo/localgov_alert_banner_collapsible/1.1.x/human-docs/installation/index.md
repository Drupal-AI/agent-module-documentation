# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **LocalGov Alert Banner** module (`localgov_alert_banner`) — this is the
  base module and is required. Composer pulls it in automatically.
- This is an **experimental** module; review the caveat on the
  [overview page](../index.md) before relying on it in production.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/localgov_alert_banner_collapsible -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer fetch LocalGov Alert
Banner and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/localgov_alert_banner_collapsible -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en localgov_alert_banner_collapsible -y
```

This also enables LocalGov Alert Banner if it is not already on.

## Verify it worked

Place the collapsible alert banner block (via **Structure → Block layout**) and
create or publish an alert banner. On the front end the alert should now offer a
collapse/expand control, and a collapsed alert can be reopened.
