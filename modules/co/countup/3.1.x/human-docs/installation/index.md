# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **CKEditor 5** (`ckeditor5`) and **Editor** (`editor`) modules — these are
  dependencies and Drupal enables them automatically.
- The external **CountUp.js** JavaScript library
  (<https://inorganik.github.io/countUp.js/>). The module's `composer.json`
  declares the asset‑packagist repository, so requiring the module with Composer
  pulls the library in for you. If you install it manually instead, place it under
  `libraries/countup.js`, with the main script at
  `libraries/countup.js/dist/countUp.umd.js`.

## Install with Composer

Installing with Composer is the recommended route, because it also fetches the
CountUp.js library:

```bash
composer require drupal/countup -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/countup -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en countup -y
```

## Verify it worked

Edit a text format at **Configuration → Content authoring → Text formats and
editors** (`/admin/config/content/formats`). The **CountUp** and **CountDown**
buttons should be available to drag into the CKEditor 5 toolbar. Add them, enable
the CountUp filter, save, and then confirm the buttons appear when you edit content
with that format — and that an inserted count‑up figure survives on the rendered
page (if it doesn't, check that the format's allowed HTML permits the widget's
markup).
