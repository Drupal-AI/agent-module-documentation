# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8||^9||^10||^11`).
- **jQuery** — the module's script requires it to run.
- A cookie‑management module that blocks content by cookie settings. The module has
  been built and tested alongside **Cookiebot**
  (`https://www.drupal.org/project/cookiebot`), which is the assumed companion.

There are no additional Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/cookie_consent_notice -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/cookie_consent_notice -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en cookie_consent_notice -y
```

That is all — **no configuration is required**. The module begins detecting blocked
elements and showing notices immediately.

## Verify it worked

On a page where your cookie manager (for example Cookiebot) blocks an embed before
consent, load the page as a visitor who has not consented. In place of the blocked
element you should now see a notice explaining that content was blocked, listing the
required cookies, and offering a link to update cookie settings.
