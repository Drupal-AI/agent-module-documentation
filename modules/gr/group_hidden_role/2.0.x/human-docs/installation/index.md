# Installation

## Requirements

Group Hidden Role is a small extension module. It needs:

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Group** module (`group`) enabled — the module it extends.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/group_hidden_role -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/group_hidden_role -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en group_hidden_role -y
```

## Submodules

Group Hidden Role ships no submodules.

## Verify it worked

Edit any group role (**Groups → Group types → *(your group type)* → Roles**) and
confirm a **Hidden role** checkbox now appears on the form. Tick it for a test
role, save, and check that the role no longer shows in the member list or the
assignable-roles list.
