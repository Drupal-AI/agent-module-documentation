# Installation

## Requirements

Help Scout Beacon has no dependencies beyond Drupal core:

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- A **Help Scout account** with a **Beacon** created — you will need its form id.
  (Create a Beacon in your Help Scout admin; this module only embeds an existing
  one.)

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/help_scout_beacon -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/help_scout_beacon -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en help_scout_beacon -y
```

## Verify it worked

After enabling, head to [Configuration](../configuration/index.md) to paste your
Beacon form id and grant the **Use Help Scout Beacon** permission. Then visit the
site as a user who has that permission — the Beacon button should appear on the page.
If you do not see it, double‑check that the current user's role has the permission
and that the form id is correct.
