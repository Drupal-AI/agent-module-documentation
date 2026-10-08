# Installation

## Requirements

- **Drupal 8 or newer** (`core_version_requirement: >=8`).
- A **Concord** account/property, so you have the details to connect the banner
  to Concord's consent platform.

There are no module dependencies and no third‑party PHP library requirements. The
consent script itself is loaded from Concord at runtime.

## Install with Composer

From the project root:

```bash
composer require drupal/concord_cookie_consent -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/concord_cookie_consent -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en concord_cookie_consent -y
```

## Verify it worked

After enabling, open the settings form (see [Configuration](../configuration/index.md))
and connect your Concord account. Then load a page on your site as an anonymous
visitor — the Concord consent banner should appear, and trackers should stay held
back until consent is given.
