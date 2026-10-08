# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- Core's **Views** module (`views`).
- The **Views Reference** module (`drupal/viewsreference`, `^2.0@beta`) — this is
  the field this module extends, and Composer will install it for you.

There are no other third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/viewsreference_filter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — here it also pulls in the required Views Reference
module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/viewsreference_filter -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en viewsreference_filter -y
```

Enabling it makes the **Exposed Filters - editor view** option available on your
Views Reference fields. To actually use it, turn that option on for a specific
field as described in the *How to use it* section on the
[overview page](../index.md). Nothing changes until you do.
