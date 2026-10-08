# Installation

## Requirements

- **Drupal 10, or 11** (`core_version_requirement: ^10 || ^11`).
- **PHP 8.1 or newer** (`php: >=8.1`).
- No dependencies beyond Drupal core, and no third‑party PHP libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/msqrole -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/msqrole -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en msqrole -y
```

The module ships no submodules.

## Grant permissions

Nobody can use the feature until you grant the permissions. At **People →
Permissions** (`/admin/people/permissions`), assign the **Masquerade role**
permission (and, if wanted, **Create masquerade role link** and the per‑role
permissions) to the roles that should have it. See
[Configuration](../configuration/index.md) for what each permission does.

## Verify it worked

Log in as a user who has the **Masquerade role** permission and go to **People →
Masquerade as role** (`/admin/people/masquerade-role`). You should see a form
listing the roles you are allowed to view the site as.
