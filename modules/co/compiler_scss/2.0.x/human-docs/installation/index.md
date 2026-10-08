# Installation

## Requirements

- **Drupal 10.6 or 11.3+** (`core_version_requirement: ^10.6 || ^11.3`).
- **PHP 8.3 or newer**.
- The **Compiler** module (`drupal/compiler` `^2.0`) — the framework this plugin
  registers against. Composer installs it automatically as a dependency.
- The **`scssphp/scssphp`** PHP library (`^2.0`), pulled in by Composer.

## Install with Composer

From the project root:

```bash
composer require drupal/compiler_scss -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and it will bring in both `drupal/compiler` and
`scssphp/scssphp`.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/compiler_scss -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en compiler_scss -y
```

Enabling `compiler_scss` also enables `compiler` if it isn't already on. If you
plan to compile a theme's SCSS assets, also install and enable **Theme Compiler**:

```bash
composer require drupal/theme_compiler -W
drush en theme_compiler -y
```

## Verify it worked

There is no UI to check. Once enabled, the `scss` compiler plugin is registered
with the Compiler framework and available to any code (or to Theme Compiler) that
asks for it. The simplest smoke test is to install Theme Compiler, declare a small
SCSS asset in a theme's `THEME.theme_compiler.yml`, rebuild caches, and confirm
the compiled `.css` appears under `public://compiled-assets/<theme>/`.
