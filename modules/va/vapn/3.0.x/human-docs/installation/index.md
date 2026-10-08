# Installation

## Requirements

- **Drupal 9.5, 10 or 11** (`core_version_requirement: ^9.5 || ^10 || ^11`).
- **PHP 8.0 or newer**.
- Core's **Node** module (`node`) enabled — it is the only dependency, and Drupal
  enables it automatically as a dependency when you turn on VAPN.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/vapn -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/vapn -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en vapn -y
```

## Grant permissions

Go to **People → Permissions** (`/admin/people/permissions`) and grant, as needed:

- **Administer VAPN** (`administer vapn`) — reach the settings form and edit the
  per-node role field. Give to administrators only.
- **Use VAPN** (`use vapn`) — edit the per-node **View access per node** field on
  the node form (without needing full administer rights). Give to content authors
  who should set per-node visibility.
- **Bypass VAPN** (`bypass vapn`) — always allowed to view any VAPN-restricted
  node, ignoring the selected roles. Give to admin/superuser-style roles.

## Next step

Nothing changes until you enable VAPN on at least one content type. See
[Configuration](../configuration/index.md).
