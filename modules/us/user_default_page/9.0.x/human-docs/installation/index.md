# Installation

## Requirements

- **Drupal 9.2, 10, or 11** (`core_version_requirement: ^9.2 || ^10 || ^11`).
- Core's **User** module (`user`), which is always present on a Drupal site.

There are no third-party Composer or PHP library requirements. The module can
*optionally* cooperate with the **Rename Admin Paths** and **Redirect** contrib
modules if you have them, but neither is required.

## Install with Composer

From the project root:

```bash
composer require drupal/user_default_page -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/user_default_page -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en user_default_page -y
```

There are no submodules.

## Next steps

No redirects happen until you create at least one rule. Head to
[Configuration](../configuration/index.md) to add your first login/logout redirect.
