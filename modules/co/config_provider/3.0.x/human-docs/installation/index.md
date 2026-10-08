# Installation

## Requirements

Configuration Provider is a small framework module with minimal requirements:

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- Core's **Configuration Manager** module (`config`) enabled — this is the only
  dependency, and Drupal enables it automatically when you turn on Configuration
  Provider.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/config_provider -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/config_provider -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en config_provider -y
```

That's all it takes. There is nothing to configure — the module simply makes its
`ConfigProvider` plugin type and `config_provider.collector` service available to
other modules and to your own code. In most cases you won't enable it directly at
all: another module (such as a config packaging or distribution tool) lists it as
a dependency and Drupal turns it on for you.
