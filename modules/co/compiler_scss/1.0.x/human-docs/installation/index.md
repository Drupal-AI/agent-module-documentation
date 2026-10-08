# Installation

## Requirements

- **Drupal 10.3 or newer, or Drupal 11** (`core_version_requirement:
  ^10.3 || ^11`).
- **PHP 8.3 or newer** (`php >=8.3`) — note this is a higher PHP requirement than
  many modules, so check your server's PHP version first.
- The **Compiler** module (`drupal/compiler` `^1.0@alpha`) — the plugin framework
  this module plugs into. Composer installs it automatically.
- The **`scssphp/scssphp`** library (`^1.10`), the pure-PHP Sass engine that does
  the actual compiling. Composer installs it automatically.

Because of the `scssphp/scssphp` library, always install this module **with
Composer** rather than by downloading a zip — Composer is what pulls the library
in.

## Install with Composer

From the project root:

```bash
composer require drupal/compiler_scss -W
```

The `-W` (`--with-all-dependencies`) flag is important here: it lets Composer
pull in the Compiler module and the `scssphp/scssphp` library and reconcile any
shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/compiler_scss -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en compiler_scss -y
```

Enabling SCSS Compiler also enables the base **Compiler** module if it isn't on
already, since it's a dependency.

## Verify it worked

There is no page to visit and nothing to configure — the module is developer
infrastructure. Once enabled, the `scss` compiler plugin is registered and
available to code (`\Drupal::service('plugin.manager.compiler')->createInstance('scss')`).
To confirm both modules are on:

```bash
drush pm:list --status=enabled | grep -E 'compiler'
```
