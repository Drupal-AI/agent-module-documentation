# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- No other modules are required, and there are no third-party Composer or PHP
  library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/simplelogin -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/simplelogin -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en simplelogin -y
```

Once enabled, the anonymous login/register/password pages immediately pick up the
module's styling (with its default sky-blue background). Head to
[Configuration](../configuration/index.md) to set your own background image or
colour and adjust the form.
