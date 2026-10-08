# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No external PHP or JavaScript library dependencies and no other module
  dependencies (it replaces core's jQuery UI dialog with the native
  `<dialog>` element).

> **Note:** This module is still marked as work in progress by its maintainers,
> so test it thoroughly before relying on it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/dialog_native -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/dialog_native -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en dialog_native -y
```

## Verify it worked

After enabling and clearing the cache (`drush cr`), trigger any Drupal dialog or
modal on your site — for example an AJAX modal link. It should now render using
the native HTML `<dialog>` element (via the `dialogAdapter` bridge) rather than
the old jQuery UI dialog. Because this is a WIP module, check your commonly used
dialogs to confirm they behave as expected.
