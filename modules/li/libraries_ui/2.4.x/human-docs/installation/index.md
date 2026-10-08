# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).

There are no other module dependencies and no third-party Composer or PHP library
requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/libraries_ui -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from your
> host machine — `ddev composer require drupal/libraries_ui -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en libraries_ui -y
```

## Grant access

The report is protected by the **Access libraries_ui** permission (restricted). Grant
it to the roles that should see the report at **People → Permissions**
(`/admin/people/permissions`), or with Drush:

```bash
drush role:perm:add administrator 'access libraries_ui'
```

## Next step

There is nothing to configure. Visit **Reports → Libraries**
(`/admin/reports/libraries`) — see [How to use it](../index.md#how-to-use-it).
