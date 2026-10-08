# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- No third-party Composer or PHP libraries, and no other contrib modules are
  required.

## Install with Composer

From the project root:

```bash
composer require drupal/allowed_values_functions -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/allowed_values_functions -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en allowed_values_functions -y
```

## Grant the permission

The module provides a permission governing who may configure a method as a
field's allowed-values function. Because the configured method runs on the
server, grant that permission on **People → Permissions**
(`/admin/people/permissions`) only to trusted developers or site builders. You
then set the method when configuring a list/options field.
