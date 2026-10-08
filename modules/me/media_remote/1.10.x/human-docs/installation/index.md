# Installation

## Requirements

Media Remote has no third-party libraries. It builds on core's media system:

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Media** module (`media`) — enabled automatically as a dependency.
- Core's **Media Library** module (`media_library`) — a hard dependency (it powers
  the "paste a URL" field in the media modal), enabled automatically.

## Install with Composer

From the project root:

```bash
composer require drupal/media_remote -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/media_remote -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_remote -y
```

Drupal enables Media and Media Library if they aren't already on. There are no
submodules and no settings form.

Enabling the module doesn't create anything by itself — it adds a new media **source**
("Remote Media URL") that you then build a media type around. Continue to
[Configuration](../configuration/index.md) to set up your first Remote Media type.

## Verify it worked

Go to **Structure → Media types → Add media type** and open the **Media source**
dropdown. You should see **Remote Media URL** listed alongside core's sources
(Image, Audio, Video, Remote video, File).
