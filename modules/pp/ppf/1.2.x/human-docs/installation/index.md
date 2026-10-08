# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- **PHP 8.0 or newer**.
- The **`symfony/filesystem`** library, which Composer pulls in automatically when
  you require the module (the module also uses Symfony's `Finder` for file
  discovery).

There are no other module dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/ppf -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ppf -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ppf -y
```

## Verify it worked

Create a file `preprocessors/node.preprocess.php` in your active theme containing
`$variables['test'] = 'it works';`, add `{{ test }}` to `node.html.twig`, clear
caches (`drush cr`), and view any node — you should see the text render. If it
does, the module is discovering and running your preprocessor files. Next, see
[Configuration](../configuration/index.md) if you want to change the folder name
or file extension.
