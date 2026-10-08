# Installation

## Requirements

- **Drupal 9.3+, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- Core's **File** (`file`) module, which Drupal enables automatically as a
  dependency.
- A **configured private filesystem** — the module moves protected files to
  `private://`, so file protection only works if private storage is set up and
  served through Drupal's access-checked delivery.

> **Deprecated:** Consider the actively maintained
> **[File Visibility](https://www.drupal.org/project/file_visibility)** module
> instead for new projects.

## Configure the private filesystem first

If you have not already, set the private file path in `settings.php`, for example:

```php
$settings['file_private_path'] = '../private';
```

Make sure the directory exists and is writable by the web server but not directly
web-accessible. Rebuild caches after changing this.

## Install with Composer

From the project root:

```bash
composer require drupal/file_access_fix -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/file_access_fix -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en file_access_fix -y
```

## Verify it worked

Attach a file to an entity that is **not** anonymously accessible (for example an
unpublished node) and confirm the file can no longer be downloaded by its direct
public URL — it should have been moved to private storage and served only through
Drupal's access-checked delivery. Test against your own content states to be sure the
mapping matches your intent.
