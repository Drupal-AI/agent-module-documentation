# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- Core's **Layout Builder** module (`layout_builder`) enabled — this is the only
  dependency, and Drupal enables it automatically when you turn on Layout Builder
  Limit.

There are no third‑party Composer or PHP library requirements. (This version is a
beta, `1.0.0-beta5`.)

## Install with Composer

From the project root:

```bash
composer require drupal/layout_builder_limit -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/layout_builder_limit -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en layout_builder_limit -y
```

After enabling, grant the module's permission to the roles that should configure
component limits, at **People → Permissions** (`/admin/people/permissions`).

## Verify it worked

Open a Layout Builder layout and configure a section. You should see options to set
a minimum and/or maximum number of components. Set a small maximum, then try to add
more blocks than allowed — Layout Builder should stop you. If it does, the module
is working.
