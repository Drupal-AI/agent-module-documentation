# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).

There are no other module dependencies and no third‑party Composer or PHP library
requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/copy_field -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/copy_field -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en copy_field -y
```

> **Tip:** because this is a build‑time developer convenience, many teams enable it
> only in development environments — for example by keeping it out of production
> config with Config Split.

## Verify it worked

Go to a content type's edit screen, e.g. **Structure → Content types → Article →
Edit** (`/admin/structure/types/manage/article`), enable the copy‑field feature,
and save. A new **Manage Copy field** tab should appear on that content type,
where you can copy field machine names with one click.
