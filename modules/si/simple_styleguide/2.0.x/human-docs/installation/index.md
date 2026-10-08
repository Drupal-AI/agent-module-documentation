# Installation

## Requirements

Simple Styleguide is self‑contained:

- **Drupal 9.1, 10, or 11** (`core_version_requirement: ^9.1 || ^10 || ^11`).
- No third‑party Composer or PHP libraries, and no other contrib modules.

## Install with Composer

From the project root:

```bash
composer require drupal/simple_styleguide -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/simple_styleguide -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en simple_styleguide -y
```

## Grant permissions

The module defines two permissions at **People → Permissions**
(`/admin/people/permissions`):

- **Access style guide** — lets a role view the `/simple-styleguide` page. Grant this
  to whoever should see the styleguide (developers, designers, reviewers).
- **Administer style guide** — lets a role add, edit, delete, and reorder custom
  patterns. This is a sensitive permission (custom patterns store raw HTML), so grant
  it only to trusted roles.

The **settings form** and the styleguide admin menu are governed separately by core's
**Administer site configuration** permission (administrators by default).

Next, head to [Configuration](../configuration/index.md) to choose your patterns and
colours.
