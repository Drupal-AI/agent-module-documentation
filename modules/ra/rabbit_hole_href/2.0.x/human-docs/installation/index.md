# Installation

## Requirements

- **Drupal 8.9, 9, 10, or 11** (`core_version_requirement: ^8.9 || ^9 || ^10 || ^11`).
- The **Rabbit Hole** module (`rabbit_hole`, ^1.0) — this is a required dependency
  and provides the redirect behaviour this module rewrites links for.

## Install with Composer

From the project root:

```bash
composer require drupal/rabbit_hole_href -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Rabbit Hole and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/rabbit_hole_href -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en rabbit_hole_href -y
```

Drupal enables Rabbit Hole at the same time if it is not already on.

## Verify it worked

First set the **page redirect** behaviour on a taxonomy term via Rabbit Hole. Then
find a link to that term (for example in a menu or a View) and check that its `href`
points to the redirect destination rather than the term's own canonical URL. Since
this module currently targets taxonomy terms only, test with a term rather than a
node.
