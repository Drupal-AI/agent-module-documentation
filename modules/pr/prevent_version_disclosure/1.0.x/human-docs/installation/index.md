# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **`league/commonmark`** PHP library — used only to render the module's help
  text. Composer installs it automatically as a dependency.

There are no other Drupal module dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/prevent_version_disclosure -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies — including `league/commonmark` — as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/prevent_version_disclosure -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en prevent_version_disclosure -y
```

That's all. There is no configuration and no permissions to grant — the module
starts rewriting JavaScript version strings immediately.

## Verify it worked

Load any page, then view its HTML source and look at a JavaScript file URL. The
version query string should now be an opaque hash (for example
`?v=d5t4a2hC`) rather than a readable version number like `?v=3.7.1`. A good
place to check is `install.php` or `update.php`, where aggregation does not
apply.
