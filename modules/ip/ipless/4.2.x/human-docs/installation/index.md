# Installation

## Requirements

- **Drupal 10, 11, or 12** (`core_version_requirement: ^10 || ^11 || ^12`).
- **PHP 8.1 or newer**.
- The **`wikimedia/less.php`** Composer library (`^3.1 || ^4 || ^5`), which provides
  the `Less_Parser` class that does the actual compiling. Composer installs it for you.
  If this library is missing, the module simply warns and does nothing.

There are no module dependencies to enable separately.

## Install with Composer

From the project root:

```bash
composer require drupal/ipless -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in `wikimedia/less.php`
and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from your
> host machine — `ddev composer require drupal/ipless -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ipless -y
```

## Next step

Nothing compiles until you switch the feature on and declare some Less files. See
[Configuration](../configuration/index.md).
