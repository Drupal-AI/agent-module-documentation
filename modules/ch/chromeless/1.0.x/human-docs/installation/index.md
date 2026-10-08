# Installation

## Requirements

- **Drupal 10.5 or 11** (`core_version_requirement: ^10.5 || ^11`).
- No other module dependencies, and no third‑party Composer or PHP library
  requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/chromeless -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/chromeless -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en chromeless -y
```

There is no required configuration or post-install step — chromeless mode is
available immediately.

## Verify it worked

Open any page on your site and add `?chromeless=1` to the URL. The page should
render with only its main content — header, footer, sidebars, and other blocks
should disappear. Removing the parameter (or using `?chromeless=0`) restores the
full layout.
