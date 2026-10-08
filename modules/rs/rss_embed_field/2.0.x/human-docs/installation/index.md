# Installation

## Requirements

- **Drupal 9.4 or 10** (`core_version_requirement: ^9.4 || ^10`).
- Core's **Link** module (`link`) — the module builds on standard Link fields, and
  Drupal enables it automatically as a dependency.
- The project should be installed **via Composer** (it pulls in the Laminas Feed
  Reader library used to parse feeds). The ZIP downloads on the project page are for
  reference only.

## Install with Composer

From the project root:

```bash
composer require drupal/rss_embed_field -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including the feed‑parsing library.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/rss_embed_field -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en rss_embed_field -y
```

## Verify it worked

Confirm the module is enabled at **Extend** (`/admin/modules`). The real test comes in
[Configuration](../configuration/index.md): add a Link field to a content type and
check that **RSS Feed** appears as a widget option on **Manage form display** and as a
format option on **Manage display**.
