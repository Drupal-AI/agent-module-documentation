# Installation

## Requirements

Group finder is a lightweight API module. It needs:

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- The **Group** module (`group`) enabled — this is the only dependency, and it is
  the module Group finder extends.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/group_finder -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/group_finder -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en group_finder -y
```

## Submodules

Group finder ships no submodules.

## Verify it worked

Group finder has no visible UI, so the simplest check is that the module appears
as *Enabled* on the **Extend** page (`/admin/modules`). In practice you will
usually enable it because another module — such as Group Media Library — requires
it, in which case that module's features are your real confirmation that group
resolution is working.
