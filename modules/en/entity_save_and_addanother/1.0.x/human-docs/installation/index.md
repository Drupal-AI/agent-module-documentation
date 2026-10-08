# Installation

## Requirements

Entity Save And Add Another is deliberately simple. It needs:

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Node**, **Taxonomy**, **Menu link content**, and **Block** modules,
  which Drupal enables automatically as dependencies. The Commerce product button
  is a bonus that appears only if you also have Commerce installed.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_save_and_addanother -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/entity_save_and_addanother -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_save_and_addanother -y
```

That's the entire setup. There is no configuration form and no per‑content‑type
switch — the **Save and Add Another** button appears immediately on the supported
add forms for any user who can already create that entity type.
