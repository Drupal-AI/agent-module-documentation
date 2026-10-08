# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- No other Drupal modules or PHP libraries are required.

Note that the behavior library loads scrollama 2.2.1 and an IntersectionObserver polyfill
from a public CDN (Cloudflare / jsDelivr), with no subresource-integrity hash. If loading
external scripts is a concern for your site, plan to self-host those assets.

## Install with Composer

From the project root:

```bash
composer require drupal/scrollama -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/scrollama -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en scrollama -y
```

There are no submodules. The libraries are off by default — see
[Configuration](../configuration/index.md) for the two ways to switch them on.
