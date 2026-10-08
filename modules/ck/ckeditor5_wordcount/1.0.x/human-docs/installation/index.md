# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3||^11`).
- **PHP 8.0 or newer**.
- Core's **CKEditor 5** module (`ckeditor5`), which Drupal enables automatically
  as a dependency.

All end-user functionality works immediately after installation — there are no
third-party libraries or APIs to set up. (Building the plugin from source needs
Node.js and Webpack, but the module ships with prebuilt assets, so you do not
need those to use it.)

## Install with Composer

From the project root:

```bash
composer require drupal/ckeditor5_wordcount -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/ckeditor5_wordcount -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ckeditor5_wordcount -y
```

## Verify it worked

Edit any content that uses a CKEditor 5 text format. A live count (for example
"Words: 245 / 500") should appear below the editor and update as you type. To set
or change the limits, see [Configuration](../configuration/index.md).
