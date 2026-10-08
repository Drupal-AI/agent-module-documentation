# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- The **`google/apiclient`** PHP library (Google's official API client), which
  Composer pulls in automatically when you install the module.
- A free **Google Calendar API key** with the Calendar API enabled.
- Each Google Calendar you want to display must be set to **public**.

## Install with Composer

From the project root:

```bash
composer require drupal/gcal_entity -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the
`google/apiclient` library and any other shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/gcal_entity -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en gcal_entity -y
```

## Verify it worked

Log in as an administrator and open the settings form at
`/admin/config/gcal_entity/config`. If it loads, continue to
[Configuration](../configuration/index.md) to enter your API key and create a
calendar.
