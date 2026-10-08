# Installation

## Requirements

- **Drupal 11 only** (`core_version_requirement: ^11`). This 2.0.x release does
  not run on Drupal 10 or earlier.
- No other module dependencies, and no third-party PHP libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/seo_analyzer -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/seo_analyzer -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en seo_analyzer -y
```

## Grant the permission

The analyzer tab is visible to administrators automatically. To let other roles
use it, go to **People → Permissions** and grant **access seo analyzer** to the
roles you choose.

## Verify it worked

Open any node as an administrator (or a user with `access seo analyzer`). You
should see an **SEO Analyzer** task link beside the *Edit* and *Translate* tabs;
clicking it shows the on-page SEO results and a keyword field. There is no
configuration form for this module — it works out of the box.
