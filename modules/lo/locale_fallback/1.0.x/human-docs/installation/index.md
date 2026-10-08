# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Language** module (`language`) — enabled automatically as a dependency.
  For interface‑string fallback to be meaningful you will also want core's
  **Interface Translation** (`locale`) set up with more than one language.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/locale_fallback -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/locale_fallback -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en locale_fallback -y
```

## Verify it worked

With at least two related languages configured (for example a base language and a
regional variant), set the variant to fall back to the base language, then view a
string that is translated in the base language but not the variant. It should now
resolve to the base language's translation rather than the site default.
