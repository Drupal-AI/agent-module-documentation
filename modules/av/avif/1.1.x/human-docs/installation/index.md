# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Image** module (`image`) — the only module dependency.
- A working **AVIF encoder on the server**. Avif defines a converter plugin type
  so encoding can use whichever backend your host provides — GD, Imagick, or a
  command‑line encoder — but one of them must actually be able to produce AVIF.
  GD's AVIF support depends on how PHP was compiled; Imagick's depends on the
  linked ImageMagick build. Check what is available before rolling out.

Note the release is **1.1.0‑rc1**, a release candidate — test it before
production use.

## Install with Composer

From the project root:

```bash
composer require drupal/avif -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/avif -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en avif -y
```

After enabling, open the settings form at **`/admin/config/media/avif`** to review
the behavior, and plan to warm your image derivatives so first‑request AVIF
encoding does not slow real page loads — see
[How to use it](../index.md#how-to-use-it) on the overview page.
