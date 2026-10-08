# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **User** (`user`) and **System** (`system`) modules — both are part of
  standard Drupal and always present.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/permissions_enhancer -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/permissions_enhancer -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en permissions_enhancer -y
```

No further configuration is needed — the module updates the display of the role
permission pages immediately.

## Verify it worked

Go to **People → Permissions** (`/admin/people/permissions`) or a single role's
permission page. You should see a summary of that role's active permissions at
the top, buttons to show or hide the permissions it does not have, and improved
styling on the table.
