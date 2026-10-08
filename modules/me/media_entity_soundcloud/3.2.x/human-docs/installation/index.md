# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- Core's **Media** module (`media`) — enabled automatically as a dependency, since this
  module plugs a SoundCloud source into it.

There are no third‑party Composer or PHP library requirements — the embedded player is
loaded by SoundCloud's own widget at runtime.

## Install with Composer

From the project root:

```bash
composer require drupal/media_entity_soundcloud -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/media_entity_soundcloud -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_entity_soundcloud -y
```

Enabling it also enables core Media if it isn't on already. There are no submodules and no
settings page. To start using it, create a media type with **Soundcloud** as its source —
see [How to use it](../index.md#how-to-use-it) on the overview page.

## Verify it worked

Create a SoundCloud media type, add an item by pasting a SoundCloud track URL, and view it.
You should see an embedded SoundCloud player, and the track's thumbnail should have been
fetched and stored locally.
