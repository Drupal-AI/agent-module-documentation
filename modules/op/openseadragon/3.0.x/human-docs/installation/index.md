# Installation

## Requirements

- **Drupal 9.1, 10, or 11** (`core_version_requirement: ^9.1 || ^10 || ^11`).
- The **Token** module (`drupal/token`, `^1.3`) — Composer installs it and Drupal
  enables it as a dependency. It's used for the `[node:…]` tokens in manifest URLs.
- A **IIIF image server** (such as [Cantaloupe](https://cantaloupe-project.github.io/))
  reachable from your site — this is what actually serves the image tiles. The module
  does not include one.

The OpenSeadragon JavaScript library loads from a CDN, so you don't need to download
any front‑end assets locally.

**Suggested:** the [Config Override Inspector](https://www.drupal.org/project/coi)
module (`drupal/coi`) helps you see config overrides on some of the settings fields.
It's optional.

## Install with Composer

From the project root:

```bash
composer require drupal/openseadragon -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer resolve the Token dependency
and update any shared packages as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/openseadragon -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en openseadragon -y
```

Drupal enables **Token** at the same time as a dependency. There are no submodules and
no permissions of the module's own (the settings form uses the core *administer site
configuration* permission).

## Before you configure

Make sure your IIIF image server is running and reachable — you'll enter its base URL
in the settings form, and the viewer renders nothing until it's set. Then continue to
[Configuration](../configuration/index.md).
