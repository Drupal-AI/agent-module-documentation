# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- **PHP 7.3 or newer**.
- A **Fastly account** with a Service configured for your site, and an **API
  token**. The local configuration works without these, but purging and VCL
  uploads need valid credentials plus network access to Fastly.

There are no contrib module dependencies for the base module.

## Install with Composer

From the project root:

```bash
composer require drupal/fastly -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/fastly -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en fastly -y
```

Then go to **Configuration → Web services → Fastly**
(`/admin/config/services/fastly`) to enter your credentials and settings — see
[Configuration](../configuration/index.md).

## The Fastly Purger submodule

Fastly ships one optional submodule:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Fastly Purger** | `fastlypurger` | Integrates Fastly with the contrib [Purge](https://www.drupal.org/project/purge) module as a *purger* plugin, so cache invalidations flow through Purge's queue and processors instead of purging inline. |

Enable it only if you use the Purge module and want Fastly to participate in its
queue:

```bash
drush en fastlypurger -y
```

If you're not using the Purge module, leave it off — the base Fastly module purges
on its own via Drupal's cache‑tag invalidation.
