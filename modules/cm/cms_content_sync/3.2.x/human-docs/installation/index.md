# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **PHP 8.0 or newer**.
- Several modules, installed by Composer and enabled as dependencies: core's
  **User**, **REST** (`rest`), **Serialization** (`serialization`) and **Menu
  link content** (`menu_link_content`), plus the contrib **Encrypt**
  (`drupal/encrypt`, `^3.0`) and **Encrypt: Real AES** (`drupal/real_aes`, `^2.0`)
  modules used to encrypt sync credentials.
- The **`edge-box/sync-core`** PHP library (`^4.2.1`), pulled in by Composer.
- **An external content-sync.io / Sync Core backend account.** The module talks to
  this backend to do the actual syndication — without it, nothing syncs. Set this
  up before you configure Flows and Pools.

## Install with Composer

From the project root:

```bash
composer require drupal/cms_content_sync -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Encrypt /
Real AES modules, the `edge-box/sync-core` library, and update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/cms_content_sync -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en cms_content_sync -y
```

The required dependency modules are enabled automatically.

## Submodules — enable only what you need

The suite ships eight optional submodules. Enable them individually with
`drush en`:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Views** | `cms_content_sync_views` | Exposes sync-status entities in Views (state, flags, pool, flow, entity type). |
| **Health** | `cms_content_sync_health` | A health dashboard for monitoring syndication. |
| **Developer** | `cms_content_sync_developer` | Developer tooling, including warnings when a Flow's entity-type version is out of date after a field change. |
| **Private environment** | `cms_content_sync_private_environment` | Lets local/private environments the backend cannot reach directly participate by polling. |
| **Simple Sitemap** | `cms_content_sync_simple_sitemap` | Carries Simple Sitemap per-entity settings across sites. |
| **DraggableViews** | `cms_content_sync_draggableviews` | Syncs DraggableViews manual ordering weights along with content. |
| **Acquia Content Hub migrate** | `cms_content_sync_migrate_acquia_content_hub` | Migrates an existing Acquia Content Hub setup into Flows and Pools. |
| **Custom field example** | `cms_content_sync_custom_field_example` | An example module showing how to write a custom field handler. |

For example, to add Views integration:

```bash
drush en cms_content_sync_views -y
```

Once enabled, register the site with your backend and set up Pools and Flows —
see [Configuration](../configuration/index.md).
