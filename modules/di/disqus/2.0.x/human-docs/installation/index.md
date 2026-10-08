# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Field** and **File** modules (`field`, `file`), which Drupal enables as
  dependencies.
- The **`disqus/disqus-php`** PHP library (`^1.0`), installed automatically by
  Composer. It is required for the API-driven features (thread update/close/remove,
  notifications); basic comment threads render without it.
- A **Disqus account** with a registered site, so you have a *shortname* to enter.

## Install with Composer

From the project root:

```bash
composer require drupal/disqus -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — here it also brings in the `disqus/disqus-php` library.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/disqus -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en disqus -y
```

After enabling, head to the settings form to enter your shortname, then attach a
Disqus comments field to a content type — both steps are covered in
[Configuration](../configuration/index.md). There are no submodules.
