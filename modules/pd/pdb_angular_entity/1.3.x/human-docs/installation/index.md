# Installation

## Requirements

- **Drupal 10.2+, 11, or 12** (`core_version_requirement: ^10.2 || ^11 || ^12`).
- **PDB — Progressively Decoupled Blocks** (`pdb`), version 3.x. This is a hard
  dependency; the module builds on PDB's component discovery.
- **Node.js 18+ and Angular CLI 21+** — needed only if you are *building* your own
  Angular component bundles. To use the bundled example components you do not need a
  build toolchain.

## Install with Composer

Installing with Composer pulls in PDB if it is not already present:

```bash
composer require drupal/pdb_angular_entity -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/pdb_angular_entity -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en pdb_angular_entity -y
```

Drupal enables `pdb` automatically as a dependency if it is not already on.

## Verify it worked

Log in as an administrator. The bundled example components (`site_info_component`,
`article_component`) should be discovered and available as blocks under **Structure →
Block layout** — place one to confirm the Angular element renders on the page. You
can also check that an **Angular Component** view mode is available on an entity
type's **Manage display**. See the module's settings at
**`/admin/config/pdb_angular_entity/settings`**.
