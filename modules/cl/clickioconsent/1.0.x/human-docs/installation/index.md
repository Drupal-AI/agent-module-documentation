# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`; the
  project targets core 8 and up).
- A **Clickio account** with a **site ID** for the property you want to protect —
  you get this from Clickio, not from Drupal.

There are no third‑party Composer or PHP library requirements, and no module
dependencies. Note that the module is not covered by Drupal's security advisory
policy.

## Install with Composer

From the project root:

```bash
composer require drupal/clickioconsent -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/clickioconsent -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en clickioconsent -y
```

## Verify it worked

After enabling, enter your Clickio site ID on the module's settings form (see
[Configuration](../configuration/index.md)). Then load a public page as an
anonymous visitor — you should see the Clickio consent banner appear, driven by the
Clickio script the module loads for your site ID.
