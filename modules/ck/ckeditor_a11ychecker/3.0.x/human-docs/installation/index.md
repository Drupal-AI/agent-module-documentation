# Installation

## Requirements

- **Drupal 9.3+, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- Core's **CKEditor 5** module (`ckeditor5`) enabled — the only dependency, and Drupal
  enables it automatically.
- No third-party PHP or Composer libraries, and **no external accessibility service or
  API key** — the Sa11y engine is bundled and runs client-side.

## Install with Composer

From the project root:

```bash
composer require drupal/ckeditor_a11ychecker -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ckeditor_a11ychecker -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ckeditor_a11ychecker -y
```

Enabling the module makes the **Accessibility Checker** button available, but it won't
appear in the editor until you add it to a text format's toolbar. See
[Configuration](../configuration/index.md).
