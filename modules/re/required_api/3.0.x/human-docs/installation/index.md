# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **PHP 8.1 or newer** (`php: 8.1`).
- No module dependencies and no third-party PHP libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/required_api -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/required_api -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en required_api -y
```

Once enabled, the field-settings form changes: the core **Required field**
checkbox is hidden and replaced by a **required strategy** chooser (when more than
one strategy is available). Out of the box only the **Core** strategy exists, so
behaviour is unchanged until you add a strategy or set the default — see
[Configuration](../configuration/index.md).

## Next steps

Required API becomes powerful once other modules provide strategy plugins (for
example "required for a role"). If you're a developer, the sibling
[`agent/`](../agent/start.md) docs describe how to implement a Required strategy
plugin.
