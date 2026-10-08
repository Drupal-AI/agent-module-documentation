# Installation

## Requirements

- **Drupal 9.2 or newer** (`core_version_requirement: >=9.2`).
- No third-party libraries and no other module dependencies.
- APE controls headers meant for an **external cache** (Varnish, a CDN, or a
  reverse proxy). It works with Drupal's page cache regardless, but the header
  control matters most when such a cache sits in front of your site.

## Install with Composer

From the project root:

```bash
composer require drupal/ape -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ape -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ape -y
```

## Submodule

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **APE test** | `ape_test` | Test-only redirect and landing endpoints (`/ape_redirect_301`, `/ape_alternative`, `/ape_exclude`) used to verify cache-header behavior. It's for development/testing only — don't enable it on a production site. |

## Grant the permission

APE defines one permission, **Administer APE** (`administer ape`, a restricted
permission). Grant it at **People → Permissions** to any trusted role that should
manage cache lifetimes.

## Next step

APE ships no default configuration — its settings object doesn't exist until you
save the form once. Head to [Configuration](../configuration/index.md) to set your
cache lifetimes.
