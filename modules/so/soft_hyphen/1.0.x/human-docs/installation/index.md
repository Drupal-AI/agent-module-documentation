# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No dependent modules, and no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/soft_hyphen -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/soft_hyphen -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en soft_hyphen -y
```

## Verify it worked

There is no settings page. To confirm the module is working, apply its soft-hyphen
formatter to a plain-text field on a content type's **Manage display** tab (or use
its Twig filter in a template), then view a piece of content with a long word in a
narrow column — the word should break cleanly at a sensible point without showing
a visible hyphen when it does not need to break. See the [main guide](../index.md)
for how to apply the formatter and filter.
