# Installation

## Requirements

Hux is a modern, code-only module with strict version requirements:

- **PHP 8.3 or newer** (`php: >=8.3`) — it relies on PHP attributes.
- **Drupal core 11.1 or newer** (`core_version_requirement: ^11.1`).
- No other module dependencies and no third-party Composer libraries.

If your site runs an older PHP or Drupal version, Hux will not install — check
these first.

## Install with Composer

From the project root:

```bash
composer require drupal/hux -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/hux -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en hux -y
```

That's all — there is no settings page and no submodules. Once enabled, Hux
discovers hook classes in any module's `Drupal\<module>\Hooks\` namespace. See the
[overview](../index.md#how-to-use-it) for how to write your first attributed hook.

Remember: after you add the **first** hook to a new class, rebuild the cache
(`drush cr`) so Hux discovers it. Adding further methods to an already-registered
class needs no rebuild.
