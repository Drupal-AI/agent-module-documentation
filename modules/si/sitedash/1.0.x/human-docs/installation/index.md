# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- The **Audit Export** module (`audit_export`) and its submodules — a hard
  dependency, since SiteDash sends its data through Audit Export.
- A **SiteDash.io account** with an authentication token.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/sitedash -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Audit Export and
any other shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/sitedash -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sitedash -y
```

Enabling SiteDash also pulls in Audit Export as its dependency.

## Verify it worked

Navigate to `/admin/config/services/sitedash`. You should see the SiteDash
settings page ready for your token. The connection is not active until you enter
it — see [Configuration](../configuration/index.md).
