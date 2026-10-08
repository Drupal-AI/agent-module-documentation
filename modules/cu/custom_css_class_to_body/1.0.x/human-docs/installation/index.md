# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Drupal core only — no other modules, no Composer libraries, no PHP requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/custom_css_class_to_body -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/custom_css_class_to_body -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en custom_css_class_to_body -y
```

## Verify it worked

After enabling, associate a class with a content type or a single node (see
[How to use it](../index.md#how-to-use-it)), then load one of those pages and
inspect the `<body>` element in your browser's dev tools — your custom class should
appear there, ready for your theme's CSS to target.
