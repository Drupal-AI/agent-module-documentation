# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`; the Composer
  constraint is `^10.3 || ^11`).
- **PHP 8.2 or higher**.
- The module pulls in `symfony/runtime` via Composer, which powers the `bin/dex`
  binary. Composer handles this automatically.

There are no other module dependencies.

> **Heads-up:** Do not use this module together with the Drupal core console
> patch. Dex Console throws an error on purpose if the core `DexCompilerPass`
> class already exists, to avoid a clash. Uninstall one before using the other.

## Install with Composer

Installing with Composer is required here, because the `dex` binary is exposed as
a Composer vendor binary (`vendor/bin/dex`). From the project root:

```bash
composer require drupal/dex_console -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/dex_console -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en dex_console -y
```

## Verify it worked

From the project root, run:

```bash
vendor/bin/dex list
```

You should see the Dex application banner and a list of any commands discovered
across your enabled modules. If a command you just added is missing, clear the
cache (`drush cr`) so the container's compiler pass re-scans the `src/Command/`
directories, then try again.
