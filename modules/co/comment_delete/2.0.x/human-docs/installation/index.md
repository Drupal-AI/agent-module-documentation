# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Comment** module (`comment`) — pulled in automatically as a dependency.

There are no third-party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/comment_delete -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/comment_delete -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en comment_delete -y
```

## Next steps

The module has no central settings page. Configure it on each comment field's edit
form and grant the delete permissions to your roles — see
[Configuration](../configuration/index.md).
