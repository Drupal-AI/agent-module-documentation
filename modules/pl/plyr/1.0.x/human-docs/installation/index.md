# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Media** module (`media`) — Drupal enables it automatically as a dependency when
  you turn on Plyr. The *Remote video* formatter is meant for an oEmbed media type such as
  core's *Remote video*.
- **No library download needed.** The Plyr JavaScript and CSS (v3.7.8) load from the public
  **cdn.plyr.io** CDN. If you must avoid the CDN and self‑host, override the `plyr/plyr`
  asset library from a custom module — there is no built‑in switch for it.

There are no PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/plyr -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host machine —
> `ddev composer require drupal/plyr -W`, `ddev drush …`. Inside the container (`ddev ssh`)
> run them without the prefix.

## Enable the module

```bash
drush en plyr -y
```

There is no configuration step and no submodules. Once enabled, choose a Plyr formatter on a
field's *Manage display* tab — see [How to use it](../index.md#how-to-use-it).
