# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- A **Spotify account** and a **Spotify app** registered on the Spotify Developer
  site (for the Client ID and Client Secret).
- No other module dependencies and no separate library to install — the module
  bundles the Spotify API wrappers it needs.

## Install with Composer

From the project root:

```bash
composer require drupal/spotify_playing -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/spotify_playing -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en spotify_playing -y
```

## After installing

Create an app on the [Spotify Developer site](https://developer.spotify.com/) to
get a **Client ID** and **Client Secret**, paste them into the module's settings
page, and copy the **Redirect URI** the settings page shows you back into your
Spotify app. See [Configuration](../configuration/index.md) for the full walk‑
through.

## Verify it worked

Once connected, place the **Spotify Now Playing** block (via **Structure → Block
layout**) and play something on Spotify — the block should update to show the
current track. Or request the JSON endpoint and confirm it returns the playing
song.
