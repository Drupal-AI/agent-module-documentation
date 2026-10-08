# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Media** module (`media`), with a **Remote Video** media type available
  (part of core's standard media setup).
- The **oEmbed Providers** module (`oembed_providers`). Composer installs it
  automatically as a dependency.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/peertube -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
as needed, and it brings in the oEmbed Providers module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/peertube -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en peertube oembed_providers -y
```

Then clear caches so the new provider is picked up:

```bash
drush cr
```

## Verify it worked

Open **Configuration → Media → PeerTube** (`/admin/config/media/peertube`). If the
form for adding PeerTube instance domains loads, the module is installed. Complete
the three configuration steps in [Configuration](../configuration/index.md), then
try adding a PeerTube video to a piece of content as a Remote Video.
