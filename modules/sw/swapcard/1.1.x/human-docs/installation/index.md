# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).
- The base **Swapcard** module has no other Drupal module dependencies.
- If you enable the **Swapcard Content** submodule, you also need the
  [Queue UI](https://www.drupal.org/project/queue_ui) module.
- A **Swapcard API key** for the event(s) you want to connect to. Before you
  start, it is worth reviewing Swapcard's own API documentation and GraphQL
  explorer.

## Install with Composer

From the project root:

```bash
composer require drupal/swapcard -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/swapcard -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the base module

```bash
drush en swapcard -y
```

This gives you the API client and the configuration form. On its own the base
module does not create any content.

## Submodules — enable what you need

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Swapcard Content** | `swapcard_content` | Creates four content types — **Swapcard Events**, **Sessions**, **Speakers**, **Exhibitors** — with their fields and relationships, and syncs them from Swapcard via a queue worker (on demand or on cron). Adds a Drush command and a purge form. **Requires the Queue UI module.** |
| **Swapcard Content Media** | `swapcard_content_media` | Adds a media image field to the Swapcard content and syncs Swapcard images — event banners, exhibitor logos, session banners, speaker photos. |

For a typical content‑sync setup, install Queue UI and enable the content
submodule:

```bash
composer require drupal/queue_ui -W
drush en swapcard_content -y
```

Then optionally add media sync:

```bash
drush en swapcard_content_media -y
```

> **Heads up:** enabling **Swapcard Content** creates four new content types
> (Events, Sessions, Speakers, Exhibitors) with all of their fields. Enable it on a
> site where adding those content types is acceptable.

## Next step

After enabling the module, paste your API key and configure the connection — see
[Configuration](../configuration/index.md).
