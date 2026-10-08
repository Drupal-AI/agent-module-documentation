# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Media** module (`media`) enabled — this is a dependency, and Drupal
  enables it automatically when you turn on Remote Audio.
- Recommended: core's **Media Library** module (`media_library`), so the "Remote
  audio" type appears in the Media Library add menu. Not strictly required.
- **Outbound HTTP** from your web server, since oEmbed fetches the embed and
  thumbnail from the provider.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/media_remote_audio -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/media_remote_audio -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_remote_audio -y
```

Enabling the module installs the `remote_audio` media type and its field and
displays automatically (from the module's optional configuration). Enable **Media**
(and ideally **Media Library**) before or together with it so that optional config
installs cleanly. There is no settings form and no permission to grant.

## Verify it worked

Go to **`/media/add/remote_audio`**, paste a Spotify, SoundCloud, or iHeartRadio URL
into the **Audio URL** field, and save. If the media saves and shows the provider's
player, everything is wired up correctly.
