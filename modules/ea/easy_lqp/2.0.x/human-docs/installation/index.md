# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Image** module (`image`) — this is the only dependency, and Drupal
  enables it automatically as a dependency when you turn on Easy LQP.

There are no third‑party Composer or PHP library requirements. The module works
even better alongside Focal Point, Image Optimize / Image Optimize Binaries,
ImageAPI Optimize WebP (for automatic WebP versions), and Imagecache External
(for external images), but none of these are required.

## Install with Composer

From the project root:

```bash
composer require drupal/easy_lqp -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/easy_lqp -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en easy_lqp -y
```

## Verify it worked

Enabling the module alone does not generate any image styles — that happens when
you save the settings form. Head to [Configuration](../configuration/index.md),
enter your width, step, and aspect-ratio values, and save. Afterwards, open
**Configuration → Media → Image styles** and confirm the new
`responsive_<ratio>_<width>w` styles (for example `responsive_16_9_150w`) have
been created. That confirms Easy LQP is wired up correctly.
