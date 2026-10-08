# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Views** module (`views`) enabled — this is the only dependency, and
  it's part of standard Drupal. You'll also want the **Views UI** module on to add
  the fields through the admin screens.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/views_cumulative_field -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/views_cumulative_field -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en views_cumulative_field -y
```

There are no submodules and nothing to configure globally. Once enabled, the two
cumulative field handlers are available in the Views UI — see the **How to use
it** section of the [overview](../index.md).
