# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Views** module (`views`) — the only dependency, and it is on by
  default in a standard Drupal install. Views powers the history display.

There are no third‑party Composer or PHP library requirements, and the module
adds no permissions of its own.

## Install with Composer

From the project root:

```bash
composer require drupal/recently_read -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/recently_read -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en recently_read -y
```

On install the module ships tracking configuration for **node** content plus a
ready‑made view called `recently_read_content`. There are no submodules.

## Verify it worked

Log in, view a node's full page, then check that a history row was recorded — the
simplest way is to place the shipped `recently_read_content` block (see
[Configuration](../configuration/index.md)) and confirm the node you just viewed
appears in it.
