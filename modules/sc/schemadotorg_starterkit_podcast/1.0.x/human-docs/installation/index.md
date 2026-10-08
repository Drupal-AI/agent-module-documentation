# Installation

## Requirements

This starter kit needs:

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3||^11`).
- The **Schema.org Blueprints** stack — `schemadotorg` and `schemadotorg_node`.
- The **Podcast** module (`podcast`) and core's **Views** (`views`).
- Supporting modules the kit builds on: **EVA** (`eva`), **EPP** (`epp`),
  **Auto Entity Label** (`auto_entitylabel`), **Config Rewrite**
  (`config_rewrite`) and **Views Add Button** (`views_add_button`).

Installing with Composer pulls these projects in as dependencies; Drupal enables
the required modules when you turn the starter kit on. There are no extra PHP or
third-party library requirements.

Because a starter kit installs configuration into the site, run it on a **fresh or
evaluation site** rather than an established production site.

## Install with Composer

From the project root:

```bash
composer require drupal/schemadotorg_starterkit_podcast -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/schemadotorg_starterkit_podcast -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en schemadotorg_starterkit_podcast -y
```

Enabling it scaffolds the PodcastSeries and PodcastEpisode content types, their
Schema.org mappings, the Views listings and the RSS feeds.

## Verify it worked

Go to **Structure → Content types** and confirm the **PodcastSeries** and
**PodcastEpisode** types are present. Add a series and an episode, then check that
the bundled Views listing and the RSS feed render. Remember the RSS feed is
**public by design** — only publish content you are happy to share openly.
