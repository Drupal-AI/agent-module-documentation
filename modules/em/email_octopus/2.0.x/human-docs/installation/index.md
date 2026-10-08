# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- An **EmailOctopus account** and an **API key** (created in your EmailOctopus
  account settings).

There are no module dependencies and no external libraries to download. On a
public site, consider adding a **spam‑protection/CAPTCHA** module to place in
front of the anonymous subscribe block (see Configuration).

## Install with Composer

From the project root:

```bash
composer require drupal/email_octopus -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/email_octopus -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en email_octopus -y
```

## Verify it worked

Go to `/admin/config/credentials` (as user 1 — see the access note in the
[main guide](../index.md)). The API key form should load, ready for your
EmailOctopus key. Once the key is saved you can browse lists and place a subscribe
block — see [Configuration](../configuration/index.md).
