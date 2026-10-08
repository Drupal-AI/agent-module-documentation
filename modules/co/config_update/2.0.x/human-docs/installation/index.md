# Installation

## Requirements

- **Drupal 9.4, 10, or 11** (`core_version_requirement: ^9.4 || ^10 || ^11`).
- **PHP 8.1**.
- Core's **Configuration Manager** module (`config`) — this is the only
  dependency, and it's part of a standard Drupal install.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/config_update -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/config_update -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

To make the services available for other modules (or Features) to use:

```bash
drush en config_update -y
```

The base module has no UI and nothing to configure — once enabled, its lister,
differ, and reverter services are available to any code that needs them.

## Enable the reports UI (recommended for humans)

If you actually want screens to *see* and *revert* changed configuration, enable
the bundled **Configuration Update Reports** submodule:

```bash
drush en config_update_ui -y
```

This adds the configuration-report and revert screens under **Configuration →
Development**, built on top of the base module's services. It's the piece most
site administrators are really after.
