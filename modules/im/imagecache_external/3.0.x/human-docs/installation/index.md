# Installation

## Requirements

- **Drupal 10.1+ or 11** (`core_version_requirement: ^10.1 || ^11`).
- Core's **Image** module (`image`) — enabled automatically as a dependency.
- The **enshrined/svg-sanitize** PHP library (`~0.22`), installed automatically by Composer
  — used to sanitise externally fetched SVG files before serving them.

## Install with Composer

From the project root:

```bash
composer require drupal/imagecache_external -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the svg-sanitize library and
update any shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/imagecache_external -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en imagecache_external -y
```

There are no submodules. Once enabled, review the settings — especially the cache directory
and the host whitelist — before you start pointing formatters at external URLs. See
[Configuration](../configuration/index.md).

## Verify it worked

Warm the cache for a known remote image and confirm it's fetched:

```bash
drush imagecache-external:generate 'https://example.com/photo.jpg'
```

It should report the local cached path (or a failure notice). Then set a link/text field
that holds an image URL to the **Imagecache External** formatter on a content type's *Manage
display* and view a node — the external image should render at your chosen image style.
