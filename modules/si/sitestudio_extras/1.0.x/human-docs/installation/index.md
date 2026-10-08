# Installation

## Requirements

- **Drupal 9.4, 10, or 11** (`core_version_requirement: ^9.4||^10||^11`).
- **Cohesion / Site Studio** (`cohesion`) enabled — this is a hard dependency,
  and the module only makes sense on a site that already uses Site Studio.

There are no additional PHP or third-party library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/sitestudio_extras -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/sitestudio_extras -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sitestudio_extras -y
```

Make sure Cohesion / Site Studio is enabled and configured first — Drupal will
enable it as a dependency if it is already present.

## Verify it worked

Open the Site Studio builder and confirm the extra custom element (for selecting
a library from your active modules and themes) is available among the elements
you can add.
