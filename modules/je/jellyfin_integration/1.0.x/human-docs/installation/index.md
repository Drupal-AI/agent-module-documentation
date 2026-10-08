# Installation

## Requirements

- **Drupal 9.4, 10, or 11** (`core_version_requirement: ^9.4 || ^10 || ^11`).
- A running **Jellyfin server** (version 10.x recommended) reachable from your
  Drupal site.
- A **Jellyfin API key** with appropriate permissions, generated in your Jellyfin
  server's admin dashboard.

There are no additional Composer or PHP library requirements — the client is built
on Drupal's bundled HTTP client.

## Install with Composer

From the project root:

```bash
composer require drupal/jellyfin_integration -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/jellyfin_integration -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en jellyfin_integration -y
```

## Verify it worked

After enabling, go to **Configuration → Media → Jellyfin Integration**
(`/admin/config/media/jellyfin`). You should see the settings form asking for a
server URL and API key. Fill those in and use the **Test connection** button as
described in [Configuration](../configuration/index.md); once it connects, the
library/movies/series browsing pages will show your media.
