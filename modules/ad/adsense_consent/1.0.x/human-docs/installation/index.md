# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No other Drupal modules are required. If you want the module to read consent
  from an existing cookie tool, you will also want **EU Cookie Compliance** or
  **Klaro** installed — but neither is mandatory; the module can use its own
  `ad_consent` cookie instead.
- A **Google AdSense account** and its publisher ID (`pub-XXXXXXXXXXXXXXXX`).

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/adsense_consent -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/adsense_consent -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en adsense_consent -y
```

No ads appear until you set a valid publisher ID on the settings form, so nothing
goes live just from enabling the module. Continue to
[Configuration](../configuration/index.md) to enter your publisher ID and choose
how ads are served.
