# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Telephone** module (`telephone`) — this is the only dependency, and
  Drupal enables it automatically as a dependency when you turn on Phone Label.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/phone_label -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/phone_label -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en phone_label -y
```

Drupal enables core's Telephone module automatically if it is not already on.

## Verify it worked

Go to **Structure → Content types → *(any type)* → Manage fields**, click **Create
a new field**, and check that **Labelled Telephone Number** appears in the list of
field types. If it does, the module is installed and ready to use.
