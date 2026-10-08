# Installation

## Requirements

- **Drupal 10.1+, 11, or 12** (`core_version_requirement: ^10.1 || ^11 || ^12`).
  Branch 1.1.x drops support for Drupal 9 and adds Drupal 12.
- No other module dependencies, and no third‑party Composer or PHP library
  requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_add_another -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_add_another -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_add_another -y
```

## Verify it worked

The button does not appear anywhere until you choose which entity types should show
it. Go to **Configuration → Content authoring → Entity Add Another**
(`/admin/config/content/entity_add_another`), enable it for at least one bundle,
then open that bundle's *add* form — you should see a **Save and Add Another**
button alongside the usual Save button. See [Configuration](../configuration/index.md)
for the details.
