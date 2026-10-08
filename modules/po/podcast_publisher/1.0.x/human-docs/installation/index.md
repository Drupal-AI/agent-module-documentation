# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- Core's **File** (`file`) and **Link** (`link`) modules — Drupal enables these
  automatically as dependencies.

Note this is an alpha release (version 1.0.0-alpha9), so treat it as evolving
software.

## Install with Composer

From the project root:

```bash
composer require drupal/podcast_publisher -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/podcast_publisher -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en podcast_publisher -y
```

Enabling the module installs the **Podcast** content type, the **Podcast Episode**
media type, and the feed View.

## Submodules

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Podcast Analytics** | `podcast_publisher_analytics` | Tracks per-episode metrics. Enable it only if you want listener analytics, and review what data it records against your site's privacy commitments. |

To add analytics:

```bash
drush en podcast_publisher_analytics -y
```

## Verify it worked

Go to **Structure** and confirm the **Podcast** content type and **Podcast
Episode** media type exist. Create a podcast at **Content → Add content →
Podcast**, add a **Podcast Episode**, then visit the feed URL rendered by the
bundled View to confirm your podcast feed is being produced.
