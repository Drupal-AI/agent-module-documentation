# Installation

## Requirements

- **Drupal 9.4, 10, or 11** (`core_version_requirement: ^9.4 || ^10 || ^11`).
- **Acquia CMS Common** (`acquia_cms_common`) — the shared Acquia CMS layer.
- Core **Media** (`media`) and **Media Library** (`media_library`).
- **Media Entity SoundCloud** (`media_entity_soundcloud`) — provides the
  SoundCloud media source.

Enabling Audio pulls in the common layer and its dependencies, so expect the
broader Acquia CMS set to come along with it.

## Install with Composer

From the project root:

```bash
composer require drupal/acquia_cms_audio -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in
`acquia_cms_common`, `media_entity_soundcloud`, and the other shared
dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/acquia_cms_audio -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en acquia_cms_audio -y
```

Drush enables the dependencies (Media, Media Library, the SoundCloud source, and
the common layer) automatically. Once it finishes, the **Audio** media type is
available under **Content → Media → Add media**. There is no required
configuration — the media type works out of the box.
