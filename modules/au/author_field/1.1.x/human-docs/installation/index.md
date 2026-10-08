# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).

The module has no other module dependencies and no third-party Composer library
requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/author_field -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/author_field -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en author_field -y
```

Once enabled, add an Author Field to a content type through **Structure →
Content types → (your type) → Manage fields**, and grant the
`administer author_field` permission to the roles that manage these fields.
