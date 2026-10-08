# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- **PHP 8.2 or newer**.
- Three third‑party PHP libraries, installed automatically by Composer:
  - `noweh/twitter-api-v2-php` (X / Twitter API v2 client)
  - `facebook/php-business-sdk` (Facebook Business SDK)
  - `nesbot/carbon` (date/time formatting)
- Accounts and API access for whichever platforms you want to use:
  - **Facebook** — an app (App ID + secret) with access to the Page you want to
    display.
  - **X (Twitter)** — API credentials **with a paid tier**; the free tier
    cannot read posts.
  - **Instagram** — a **Professional (Creator or Business)** account on the
    Instagram Graph API (the old Basic Display API was discontinued in December
    2024).

## Install with Composer

Because this module pulls in PHP libraries, always install it with Composer (do
not download it as a zip):

```bash
composer require drupal/socialfeed -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the three
libraries and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/socialfeed -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en socialfeed -y
```

Or enable **Social Feed** from **Extend** (`/admin/modules`).

There are no submodules. After enabling, head to
[Configuration](../configuration/index.md) to enter your platform credentials —
nothing appears on the site until you configure at least one platform and place
its block.
