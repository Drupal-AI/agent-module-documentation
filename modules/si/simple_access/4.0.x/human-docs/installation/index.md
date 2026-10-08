# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- Core's **Node** module (`node`), which Drupal enables automatically as a
  dependency.
- No third-party Composer or PHP library requirements.

Note that the 4.0.x branch is an **alpha** release — test it thoroughly before
relying on it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/simple_access -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/simple_access -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en simple_access -y
```

Enabling the module changes nothing about who can see your existing content —
nodes only become private once you assign them to an access group. Next, create
your groups and assign nodes; see [Configuration](../configuration/index.md).

## Verify it worked

After clearing caches, rebuild node access permissions if prompted (Drupal will
usually ask you to visit the status report or run the rebuild). Then create a test
access group and assign a test node to it, and confirm that a user outside the
group cannot see the node in listings, search, or on its page.
