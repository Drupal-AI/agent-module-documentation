# Installation

## Requirements

- **Drupal 9.4, 10, or 11** (`core_version_requirement: ^9.4 || ^10 || ^11`).
- No other module dependencies — it depends on Drupal core only.
- A **running PhotoPrism instance** that Drupal can reach over the network, and an
  access token or app password for it.

There are no third‑party Composer or PHP library requirements.

> **Note:** this project is not covered by Drupal's security advisory policy, and it
> is looking for co‑maintainers. Review it accordingly before relying on it for a
> high‑value site.

## Install with Composer

From the project root:

```bash
composer require drupal/photoprism_integration -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/photoprism_integration -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en photoprism_integration -y
```

## Verify it worked

Go to **Configuration → Media → PhotoPrism Integration**
(`/admin/config/media/photoprism`). If the settings form loads, the module is
installed. Enter your PhotoPrism server URL and access token and use the **Test
Connection** button to confirm Drupal can reach the server — see "How to use it" on
the [overview page](../index.md).
