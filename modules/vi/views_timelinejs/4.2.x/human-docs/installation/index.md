# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Views** module (`views`) — the only dependency, and enabled in most
  Drupal installs already.
- The **TimelineJS3** JavaScript library. By default the module loads it from the
  Knight Lab CDN, so nothing extra is needed to get started. If you want to serve
  it locally instead (for privacy or offline use), download TimelineJS3 into
  `libraries/timeline3` — see [Configuration](../configuration/index.md).

There are no Composer library requirements beyond core.

> **A note on licensing and privacy:** the CDN option loads assets remotely from
> `cdn.knightlab.com`, and TimelineJS is MPL-licensed rather than GPL. If either
> matters to you, use the local library option described in Configuration.

## Install with Composer

From the project root:

```bash
composer require drupal/views_timelinejs -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/views_timelinejs -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en views_timelinejs -y
```

Drupal enables Views automatically as a dependency if it is not already on. Once
enabled, the **TimelineJS** format becomes available on any View — see
[Configuration](../configuration/index.md) to build your first timeline.
