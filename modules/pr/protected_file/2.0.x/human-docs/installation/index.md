# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core **Field** (`field`) and **File** (`file`) modules — enabled automatically as
  dependencies.
- **A private filesystem must be configured.** The Protected File field only works
  with the `private://` stream wrapper, because only private files are served through
  the download hook where protection is enforced. If your site has no private files
  path, set one in `settings.php`:

  ```php
  $settings['file_private_path'] = '../private';
  ```

  (Point it at a directory *outside* the web root.) The module raises a warning on
  install and at runtime if no private scheme is configured.

There are no third-party Composer or PHP libraries to install.

## Install with Composer

From the project root:

```bash
composer require drupal/protected_file -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/protected_file -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en protected_file -y
```

## After enabling

There is no settings page to visit. Add a Protected File field to a content type and
grant the download permission — see [Configuration](../configuration/index.md).
