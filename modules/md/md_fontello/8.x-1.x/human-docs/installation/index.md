# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- No third‑party Composer or PHP library requirements. You supply the icons themselves by
  downloading a font bundle from [fontello.com](https://fontello.com) and importing it
  after the module is enabled.

## Install with Composer

From the project root:

```bash
composer require drupal/md_fontello -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/md_fontello -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en md_fontello -y
```

## Submodule

Fontello Icon ships one optional submodule:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Icon Link** | `md_icon_link` | A field that pairs a link with a chosen Fontello icon, selected through a UI. |

Enable it only if you need icon‑enhanced link fields:

```bash
drush en md_icon_link -y
```

## Verify it worked

Go to **Structure → Fontello Icon → Add** (`/admin/structure/md_fontello/add`). If the
import form loads, the module is active and ready for you to upload a Fontello font bundle.
See "How to use it" in the [overview](../index.md) for importing a set and rendering icons
in Twig.
