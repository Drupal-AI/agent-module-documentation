# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Entity Extra Field** module (`entity_extra_field`) — this module is a set
  of plugins for it, so it is required.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/eef_duplicate_fields -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in and update the
Entity Extra Field dependency as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/eef_duplicate_fields -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en eef_duplicate_fields -y
```

Drupal will enable Entity Extra Field as a dependency if it is not already on.

## Verify it worked

Go to a bundle's **Manage display** (for example *Structure → Content types →
Article → Manage display*) and start Entity Extra Field's "Add extra field" flow.
If **Duplicate Field** and **Referenced Entity Field** appear as plugin choices,
installation succeeded.
