# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Profile fields to measure — for example the fields on the core user account, or a
  profile provided by the core **Profile** module. PCP measures how many of the
  fields you nominate have been filled in.
- No third-party Composer libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/pcp -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/pcp -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en pcp -y
```

## Verify it worked

Log in as an administrator and open the Profile Complete Percentage settings form
(under **Configuration**). Choose which fields count toward completeness (see
[Configuration](../configuration/index.md)), place the completion block via
**Structure → Block layout**, then view your own account — the block should show a
percentage that increases as you fill in the nominated fields.
