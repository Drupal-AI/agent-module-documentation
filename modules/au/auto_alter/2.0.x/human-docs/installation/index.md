# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Image** module (`image`) enabled — the only dependency, enabled
  automatically.
- An account with one of the supported vision services — **Microsoft Cognitive
  Services Computer Vision** or **Alttext.ai** — and an API key from it. This is
  a paid, per-image service.

There are no third-party Composer library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/auto_alter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/auto_alter -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en auto_alter -y
```

## Optional submodule — translation

Automatic Alternative Text ships one optional submodule:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Auto Alter Translate** | `auto_alter_translate` | Extends the generated alt text into other languages. Enable it only if you run a multilingual site and want translated descriptions. |

Enable it with:

```bash
drush en auto_alter_translate -y
```

After enabling, configure the provider and credentials before generation will
work — see [Configuration](../configuration/index.md).
