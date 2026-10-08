# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- No third‑party Composer or PHP library requirements, and no other Drupal module
  dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/dynamic_links -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/dynamic_links -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en dynamic_links -y
```

## First steps after enabling

Grant the module's permission to the roles that should manage dynamic links under
**People → Permissions**, then create your first dynamic link at
`/admin/structure/dynamic-link/add` (see "How to use it" on the
[overview page](../index.md)).

## Verify it worked

Create a dynamic link with two candidate targets, then access it as users with
different access rights and confirm each is sent to (or shown, in subrequest mode) the
first target they're permitted to view.
