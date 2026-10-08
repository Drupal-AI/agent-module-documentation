# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`). This
  release does not declare Drupal 11 support — check the project page for a newer
  release if you are on Drupal 11.
- No additional Composer or PHP library dependencies.
- A **Poool Access** account (poool.fr) with an **application id**. The tracker
  script loads from `assets.poool.fr` over HTTPS, so visitors' browsers must be
  able to reach Poool.

## Install with Composer

From the project root:

```bash
composer require drupal/poool -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/poool -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en poool -y
```

## A note on the application id

The Poool **application id is a public key**, not a secret — it is designed to be
embedded in the page for the browser. You do **not** need to store it as an
environment variable or a Key entity; enter it directly in the settings form (see
[Configuration](../configuration/index.md)). The module stores and transmits no
secret API key.

## Verify it worked

Log in as an administrator and visit **Configuration → Web services → Poool**
(`/admin/config/services/poool`). Enter your application id and configure at least
one page type, then view a page marked as premium as an anonymous visitor — Poool's
widget should blur or truncate the content in the browser.
