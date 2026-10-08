# Installation

## Requirements

- **Drupal 8.8 or newer**, including 9, 10, and 11 (`core_version_requirement:
  ^8.8 || ^9 || ^10 || ^11`).
- No module dependencies and no third-party PHP libraries.

> **Note:** the current release of this branch is a beta (2.0.0-beta4). Test it on
> a non-production environment before relying on it.

## Install with Composer

From the project root:

```bash
composer require drupal/read_time -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/read_time -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en read_time -y
```

## Verify it worked

Go to a content type's **Manage display** (**Structure → Content types →
*(type)* → Manage display**) and confirm that a **Read time** pseudo-field is
listed. Move it into a visible region, then view a piece of that content to see
the estimated reading time. Tune the details in
[Configuration](../configuration/index.md).
