# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- **Token** module, version 1.1 or newer (`drupal/token ^1.1`) — used for the templated
  button labels.
- **Twig Tweak** module, version 3.2 or newer (`drupal/twig_tweak ^3.2`).
- No third-party PHP libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/disclosure_menu -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including pulling in Token and Twig Tweak if they aren't
already present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/disclosure_menu -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en disclosure_menu -y
```

Token and Twig Tweak are enabled automatically as dependencies. Once enabled, place a
Disclosure Menu block via Block layout and configure it — see
[Configuration](../configuration/index.md).
