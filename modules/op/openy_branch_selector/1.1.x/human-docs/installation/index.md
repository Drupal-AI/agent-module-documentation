# Installation

> **Read this first.** This module can only be installed on a site built from the
> [Open Y / YMCA Website Services](https://www.drupal.org/project/openy)
> distribution. Its dependency `openy_loc_branch` is **not** a separate drupal.org
> project — it ships inside Open Y, and there is no `drupal/openy_loc_branch`
> package for Composer to fetch. On a standalone Drupal site, `drush en
> openy_branch_selector` fails with *"missing its dependency module
> openy_loc_branch."*

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **`openy_loc_branch`** — provided by the Open Y distribution, not separately
  installable. This must already be present, which in practice means you are on an
  Open Y site.

## Install with Composer

On an Open Y site, from the project root:

```bash
composer require drupal/openy_branch_selector -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. (The `openy_loc_branch` dependency comes from the Open Y
distribution already present in your codebase, not from this command.)

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/openy_branch_selector -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en openy_branch_selector -y
```

If this fails with a message about a missing `openy_loc_branch` dependency, it
confirms you are not on an Open Y site — the module cannot be used there.

## Verify it worked

On an Open Y site with branch content present, enable the module and confirm the
branch selection / "My YMCA" link appears in the navigation. Choose a branch and
verify it is remembered on subsequent pages (the choice is stored in a cookie).
