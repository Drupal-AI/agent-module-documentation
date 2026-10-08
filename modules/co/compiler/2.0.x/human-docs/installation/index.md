# Installation

## Requirements

- **Drupal 10.6 or 11.3+** (`core_version_requirement: ^10.6 || ^11.3`).
- **PHP 8.3 or newer**.
- No other modules and no third-party libraries are required — Compiler is pure
  API with no dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/compiler -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. In most cases you won't install Compiler directly — it is
pulled in automatically when you require a module that depends on it, such as
`drupal/compiler_scss` or `drupal/theme_compiler`.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/compiler -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en compiler -y
```

## Verify it worked

Compiler has no UI, so there's nothing visible to check. Enabling it simply makes
the `compiler` plugin type and the `plugin.manager.compiler` service available for
other modules. To actually do something useful, enable a module that provides or
uses a compiler plugin — for example **SCSS Compiler** (`compiler_scss`) to add an
`scss` compiler, and **Theme Compiler** (`theme_compiler`) to build theme assets
with it.
