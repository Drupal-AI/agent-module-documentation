# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **[Webform](https://www.drupal.org/project/webform)** module (`webform`) —
  the forms it protects.
- The **[AI](https://www.drupal.org/project/ai)** module (`ai`), configured with
  a working AI provider whose API key is stored as a secret (via the Key module,
  env‑backed).

## Install with Composer

From the project root:

```bash
composer require drupal/ai_webform_guard -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ai_webform_guard -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_webform_guard -y
```

This ensures `ai` and `webform` are enabled too. Then turn on the AI spam
protection on the individual webforms you want guarded.
