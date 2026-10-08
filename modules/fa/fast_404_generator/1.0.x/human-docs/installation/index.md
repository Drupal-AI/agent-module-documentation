# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- The contrib **Fast 404** module (`fast404`) — this module builds on top of it
  and lists it as a hard dependency, so Composer and Drupal will pull it in for
  you. Install and configure Fast 404 per its own documentation first.

There are no third‑party PHP libraries to add.

## Install with Composer

From the project root:

```bash
composer require drupal/fast_404_generator -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and will bring in the Fast 404 module too.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/fast_404_generator -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en fast_404_generator -y
```

This enables Fast 404 Generator (and Fast 404 if it was not already on).

## Wire it into settings.php

Add the following to your site's `settings.php` so Fast 404 serves the generated
file:

```php
$site_404 = DRUPAL_ROOT . '/' . $site_path . '/files/404.html';
$settings['fast404_HTML_error_page'] = file_exists($site_404) ? $site_404 : FALSE;
$settings['fast404_path_check'] = file_exists($site_404);
```

Then clear the site caches:

```bash
drush cr
```

## Verify it worked

Once the `404.html` file has been generated into `sites/default/files/`, request a
non‑existent path on the site (for example `/this-page-does-not-exist`). You should
see your themed error page — with the site's header, menu, and footer — served
quickly. You can also fetch `/sites/default/files/404.html` directly to inspect the
generated markup. Remember to regenerate it after any theme, menu, or source‑node
change so it does not go stale.
