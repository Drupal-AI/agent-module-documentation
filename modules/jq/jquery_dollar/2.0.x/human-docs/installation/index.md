# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- No other modules, PHP extensions, or third‑party libraries are required.

## Install with Composer

From the project root:

```bash
composer require drupal/jquery_dollar -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/jquery_dollar -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en jquery_dollar -y
```

That's the entire setup. There is no configuration form.

## Verify it worked

Open any page on your site, then open your browser's JavaScript console and type
`$`. It should report the jQuery function rather than being undefined. If you have
a script that uses plain `$(...)`, it should now run without needing to reference
`jQuery` explicitly.
