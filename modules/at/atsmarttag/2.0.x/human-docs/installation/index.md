# Installation

## Requirements

AT Internet SmartTag needs:

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- An **AT Internet / Piano Analytics** account, so you have a **site id** and know
  your collection domains.

There are no module dependencies and no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/atsmarttag -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/atsmarttag -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en atsmarttag -y
```

## Next step

Enabling the module does not start tracking on its own — you must enter your site
id and collection details first. Grant the **Administer AT Internet SmartTag**
permission to trusted administrators, then work through
[Configuration](../configuration/index.md).
