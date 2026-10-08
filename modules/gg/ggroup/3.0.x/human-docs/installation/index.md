# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **[Group](https://www.drupal.org/project/group)** module (`^3.0`) — this is
  the only dependency, and Subgroup is meaningless without it. Composer pulls it in
  for you if it isn't already present. You'll want at least one group type set up
  in Group before configuring subgroups.

There are no third-party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/ggroup -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and pulls in the Group module if you don't already have
it.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ggroup -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ggroup -y
```

Enabling the module creates the hierarchy table it uses to track parent/child
relationships. Nothing changes for editors until you enable subgroups on a group
type — see [Configuration](../configuration/index.md).
