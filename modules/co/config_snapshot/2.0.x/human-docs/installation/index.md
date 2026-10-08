# Installation

## Requirements

Configuration Snapshot is a small API module with minimal requirements:

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 ||
  ^11`).
- Core's **Configuration Manager** module (`config`) enabled — this is the only
  dependency, and Drupal enables it automatically when you turn on Configuration
  Snapshot.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/config_snapshot -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/config_snapshot -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en config_snapshot -y
```

That's all it takes. There is nothing to configure — the module simply makes its
snapshot storage API available to other modules and to your own code. In most
cases you won't enable it directly at all: another module (such as Features) lists
it as a dependency and Drupal turns it on for you.
