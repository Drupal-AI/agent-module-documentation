# Installation

## Requirements

Composer Deploy needs:

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- **PHP 8.1 or newer** (`php: >=8.1`).
- The **`webflo/drupal-finder`** library (`^1.3`) — used to locate the Composer
  vendor directory and lockfile. Composer installs it for you.
- No other Drupal modules are required.

Naturally, this module only does anything useful on a site whose contrib is
installed via **Composer** (that's the whole point) — it reads
`vendor/composer/installed.json`.

## Install with Composer

From the project root:

```bash
composer require drupal/composer_deploy -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in
`webflo/drupal-finder` and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/composer_deploy -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en composer_deploy -y
```

Once enabled it just works — visit **Reports → Available updates**
(`/admin/reports/updates`) and your module/theme versions should now be correct.
There is no required configuration; see the [overview](../index.md#how-to-use-it)
for the optional custom-vendor-prefix setting.
