# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Quick Links** recipe/module, which this module formats. The Olivero
  block placement applies when you are using the **Olivero** theme.

There are no other contrib‑module or PHP‑library dependencies. Note that this release
is a **beta** (1.0.0‑beta1) and the project is *not* covered by Drupal's security
advisory policy — weigh that before relying on it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/quick_links_format_olivero -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/quick_links_format_olivero -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en quick_links_format_olivero -y
```

## Verify it worked

With the Quick Links recipe in place and the Olivero theme active, open the home page
— the quick‑links block should appear at the top, styled for Olivero. If you are on a
custom theme, this module is best used as a formatting reference rather than enabled
directly.
