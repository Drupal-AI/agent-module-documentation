# Installation

## Requirements

- **Drupal 9.4, 10, or 11** (`core_version_requirement: ^9.4 || ^10 || ^11`).
- The **Entity Construction Kit** module (`eck`), version **2.1 or newer**.
- Core's **Options** module (`options`).

Drupal will enable the dependencies automatically. There are no third‑party PHP
library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/eck_site_settings -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/eck_site_settings -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en eck_site_settings -y
```

This also enables `eck` and `options` if they are not already on. During
installation the module automatically creates a **Settings** ECK entity type with
a **General** bundle, so you can begin adding fields right away.

## Submodules

- **ECK Site Settings Domain** (`eck_site_settings_domain`) — adds per‑domain
  settings values for sites using the Domain module. Enable it when you need
  per‑domain values:

  ```bash
  drush en eck_site_settings_domain -y
  ```

## Verify it worked

Go to **Content → Site settings** (`/admin/content/site-settings`). You should see
the **General** bundle listed, ready for you to add fields. If it's there, the
module is working — continue to [Configuration](../configuration/index.md).
