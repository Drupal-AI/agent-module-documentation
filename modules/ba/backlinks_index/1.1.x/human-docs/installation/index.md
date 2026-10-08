# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- **Hook Post Action** (`hook_post_action`) — provides the node "post save" hook
  the module indexes on.
- **Redirect** (`redirect`) — lets the module follow redirect source paths when
  resolving internal links.

Both dependencies are contrib modules and are pulled in automatically when you
require this module with Composer.

## Install with Composer

From the project root:

```bash
composer require drupal/backlinks_index -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer fetch the Hook Post
Action and Redirect dependencies along with the module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/backlinks_index -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en backlinks_index -y
```

Drupal will enable Hook Post Action and Redirect at the same time if they are not
already on. Then head to [Configuration](../configuration/index.md) to choose
which content types are scanned and build the initial index.
