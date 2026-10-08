# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11.0`).
- Core's **Media** module (`media`) enabled — the only dependency, and Drupal
  enables it automatically when you turn this module on.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/oembed_lazyload -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/oembed_lazyload -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en oembed_lazyload -y
```

Nothing changes visually until you assign the **Lazy load oEmbed video** formatter
to a field on a **Manage display** page — see the module overview for the steps.

## Submodule — YouTube enhancer

An optional submodule adds a YouTube‑specific enhancer with player options:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **oEmbed lazy load YouTube** | `oembed_lazyload_youtube` | A YouTube provider enhancer exposing player options such as autoplay, modest branding, and related‑video behaviour. |

```bash
drush en oembed_lazyload_youtube -y
```

It requires the base oEmbed lazy load module, which is already present once you
have installed it above.
