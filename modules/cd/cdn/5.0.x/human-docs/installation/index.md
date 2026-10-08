# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- **PHP 8.3 or newer** (`php: >=8.3`).
- An **Origin Pull CDN** (for example CloudFront or similar), configured to pull from
  your site's origin. This is set up in your CDN provider, not in Drupal.

There are no third-party PHP libraries to install.

## Install with Composer

From the project root:

```bash
composer require drupal/cdn -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from your
> host machine — `ddev composer require drupal/cdn -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en cdn -y
```

## Optional: the CDN UI submodule

The base `cdn` module has no admin interface. To configure it through a form, enable
the bundled **CDN UI** submodule:

```bash
drush en cdn_ui -y
```

Its settings form appears at **Configuration → Development → CDN**
(`/admin/config/development/cdn`). Because all settings live in the `cdn.settings`
config object, you can **uninstall CDN UI again** once you've finished configuring —
the settings remain in place. (If you manage config as code, you can skip the UI
entirely and edit `cdn.settings` directly.)

## Verify it worked

After configuring a CDN domain and turning on the master **status** switch (see
[Configuration](../configuration/index.md)), load a page and inspect the URLs of your
CSS/JS/images — they should now point at your CDN domain rather than your web server.
You can also read the active state with:

```bash
drush config:get cdn.settings status
drush config:get cdn.settings mapping
```
