# Installation

## Requirements

- **Drupal 9, 10 or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **User** (`user`) module — always present in a standard install.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/displayrole -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/displayrole -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en displayrole -y
```

## Verify it worked

Go to **Configuration → People → Account settings → Manage display**
(`/admin/config/people/accounts/display`). You should now see a **Roles** row in
the field list. Drag it into a visible region, save, then view any user profile —
the user's roles should appear where you placed them.
