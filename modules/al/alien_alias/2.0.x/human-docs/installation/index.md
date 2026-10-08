# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).
- No third-party Composer or PHP libraries, and no other contrib modules are
  required.

## Install with Composer

From the project root:

```bash
composer require drupal/alien_alias -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/alien_alias -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en alien_alias -y
```

## Assign the permissions

Alien Alias provides granular permissions — add, edit, delete, view, and a
**restricted** administer permission for alien alias entities. Go to **People →
Permissions** (`/admin/people/permissions`) and grant these only to trusted
roles, because whoever can add or edit an alias decides where visitors get
redirected. Once permissions are set, create your first alias entity in the admin
UI.
