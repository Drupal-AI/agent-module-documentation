# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **RESTful Web Services** module (`rest`) — a hard dependency, used for the
  scan data resources.
- Core's **Language** module (`language`) — a hard dependency.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/siteimprove_accessibility -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/siteimprove_accessibility -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en siteimprove_accessibility -y
```

Enabling the module also brings in core's `rest` and `language` modules as
dependencies.

## Verify it worked

Log in as an administrator and visit
`/admin/reports/siteimprove_accessibility` — the compliance dashboard should load
(empty until you run scans). Then head to
[Configuration](../configuration/index.md) to grant permissions, set the scan
options, and enable the REST resources so the front‑end can save and read scan
data.
