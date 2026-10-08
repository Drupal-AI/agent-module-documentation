# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Views** module (part of Drupal core) enabled — this is where the field
  is used.

There are no third‑party Composer or PHP library requirements, and no other
module dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/logged_in -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/logged_in -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en logged_in -y
```

## Verify it worked

Edit any view that lists users (**Structure → Views**), click **Add** under
**Fields**, and search for **Logged In**. If the field appears in the list and can
be added, the module is installed and working. There is nothing else to set up.
