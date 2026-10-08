# Installation

## Requirements

- **Drupal 9.2, 10, or 11** (`core_version_requirement: ^9.2 || ^10 || ^11`).
- The **Group** module (`drupal/group`, version **2.x or 3.x**) — Entity Group Field is
  an add-on to Group and does nothing without it. Composer installs it as a dependency.
- No third-party PHP library requirements.

The module works with both Group 2.x and 3.x and automatically resolves the correct
underlying relationship entity (`group_content` on 2.x, `group_relationship` on 3.x), so
you don't need to worry about which one your site uses.

## Install with Composer

From the project root:

```bash
composer require drupal/entitygroupfield -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and pulls in the Group module if it isn't already present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entitygroupfield -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entitygroupfield -y
```

Enabling it also enables the required **Group** module. The computed **Groups** field is
then attached (in the hidden region) to every entity type that has a Group relation. It
won't appear on any form until you enable it per bundle on **Manage form display** — see
[How to use it](../index.md#how-to-use-it) on the main page. There are no submodules.
