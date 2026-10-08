# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Rabbit Hole** module (`rabbit_hole`) — a required dependency that provides
  the page‑behaviour settings this module aligns links with.

## Install with Composer

From the project root:

```bash
composer require drupal/rabbit_hole_links -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Rabbit Hole and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/rabbit_hole_links -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en rabbit_hole_links -y
```

Drupal enables Rabbit Hole at the same time if it is not already on.

## Verify it worked

Configure a Rabbit Hole behaviour on an entity — for example set a node to
**Redirect** — then, as a user without the Rabbit Hole bypass permission, find a link
to that node in a menu or View. Its link should point to the redirect target. Set
another entity to **Page not found** or **Access denied** and confirm its link is
disabled.
