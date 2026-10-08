# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- Contributed modules (installed automatically with the command below):
  - **Entity Browser** (`entity_browser` `^2.11`), including its
    `entity_browser_entity_form` submodule.
  - **Inline Entity Form** (`inline_entity_form` `^3.0@RC`).
- Core's **Media** (`media`) and **Views** (`views`) modules, enabled
  automatically as dependencies.
- To embed media in WYSIWYG you will also want **Entity Embed** configured, which
  the browsers integrate with.

There are no third‑party Composer library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/media_entity_browser -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Entity Browser and
Inline Entity Form and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/media_entity_browser -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_entity_browser -y
```

Enabling installs the browser configuration (a browser, a View, an image style,
and an embed button), but nothing is visible until you wire a browser into an
Entity Embed button or a media reference field widget — see the
[overview](../index.md#how-to-use-it).

## Optional submodule — Media Library look

Media Entity Browser ships one submodule,
**`media_entity_browser_media_library`**, which offers an alternative browser whose
UX mirrors core Media Library for WYSIWYG embedding:

```bash
drush en media_entity_browser_media_library -y
```

Enable it if you prefer that experience over the default thumbnail‑grid browser.
