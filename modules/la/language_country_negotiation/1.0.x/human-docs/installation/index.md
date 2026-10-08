# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Interface Translation** (`locale`) and **Path Alias** (`path_alias`)
  modules, enabled automatically as dependencies. (Locale in turn brings in
  **Language**, which you'll use to add the site's languages.)

There are no third‑party Composer or PHP library requirements.

> **Alpha software.** This module is an alpha release under active development.
> Test it on a non‑production environment against your Drupal version first.

## Install with Composer

From the project root:

```bash
composer require drupal/language_country_negotiation -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/language_country_negotiation -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en language_country_negotiation -y
```

## Verify it worked

After enabling, work through the setup steps in
[Configuration](../configuration/index.md): add your languages and countries, then
activate the **Language‑country URL** detection method. Once it's active, visiting a
URL like `example.com/en-ca` should serve English and register Canada as the
current country.
