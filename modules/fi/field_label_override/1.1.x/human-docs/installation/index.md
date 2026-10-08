# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).

There are no contributed module or third‑party PHP library requirements — the
module builds on core's field display system.

## Install with Composer

From the project root:

```bash
composer require drupal/field_label_override -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/field_label_override -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en field_label_override -y
```

## Verify it worked

Go to an entity's **Manage display**, pick a view mode (for example *Teaser*),
and open a field's display settings — you should be able to enter a custom
override label for that field in that view mode. Set one, save, and view the
entity in that view mode to confirm the field shows your overridden label while
other view modes keep their own.
