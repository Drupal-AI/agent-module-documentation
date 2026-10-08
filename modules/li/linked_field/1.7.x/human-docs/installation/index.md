# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- Core's **Field** module (`field`) — always present on a content site.
- The **Token** module (`token`) — used for token replacement in custom
  destinations, link text, and attributes. It is listed as a dependency, so
  Composer pulls it in.

There are no other third-party libraries to install.

## Install with Composer

From the project root:

```bash
composer require drupal/linked_field -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Token and update
any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/linked_field -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en linked_field -y
```

## Next steps

There's nothing you must configure globally. Go to any field's **Manage display**
formatter settings and tick **Link this field** to start — see
[Configuration](../configuration/index.md) for the details, including the optional
admin page for customizing which link attributes are offered.

There are no submodules.
