# Installation

## Requirements

- **Drupal 9.5, 10, or 11** (`core_version_requirement: ^9.5 || ^10 || ^11`).
- Core's **User** module (`user`) — always on.
- Core's **Path Alias** module (`path_alias`) — enabled automatically as a
  dependency; the ignore-list matching checks the current path's alias.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/user_redirect -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/user_redirect -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en user_redirect -y
```

## One important note after enabling

The module ships **no default configuration**, so nothing happens until you open
its settings form and save it at least once. Until then, logging in and out behaves
exactly as core does. Head to
[Configuration](../configuration/index.md) to set your per-role login and logout
destinations. You will also want to grant the *Administer User Redirect Settings*
permission at `/admin/people/permissions` to whoever manages the form.
