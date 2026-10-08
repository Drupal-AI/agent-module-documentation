# Installation

## Requirements

RoleAssign depends only on Drupal core:

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- Core's **User** system, always present.

There are no third-party Composer packages or other contributed modules to
install.

## Install with Composer

From the project root:

```bash
composer require drupal/roleassign -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/roleassign -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en roleassign -y
```

## Next steps

After enabling, you need to do two things — pick the assignable roles and grant
the delegation permission. See [Configuration](../configuration/index.md) for the
walkthrough.

There are no submodules.
