# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- An **Acquia Cloud Site Factory** environment — the module reports across the
  sites in a factory, so it is only meaningful there.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/acsf_module_listing -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/acsf_module_listing -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en acsf_module_listing -y
```

After enabling, grant the **Administer ACSF environment entity**
(`administer acsf_environment_entity`) permission to your factory operators under
**People → Permissions** so they can view the listing. There is no further
configuration.
