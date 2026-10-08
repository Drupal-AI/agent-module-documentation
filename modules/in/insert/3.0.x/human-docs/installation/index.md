# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **File** (`file`) and **Image** (`image`) modules — both are standard core
  modules and Drupal enables them automatically as dependencies.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/insert -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/insert -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en insert -y
```

Enabling the module does not, on its own, change any edit form — Insert only appears once
you enable at least one insert style on a specific field's widget. See
[Configuration](../configuration/index.md).

## Submodules — enable only what you need

Insert ships three optional submodules that add new insert styles by implementing Insert's
hooks. Enable them individually with `drush en`:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Insert Media** | `insert_media` | Lets editors insert Media Library items in a chosen view mode. Also ships a CKEditor 5 plugin that stops the editor from stripping Insert's markup — enable that plugin on the format's CKEditor 5 config to keep inserted markup intact. |
| **Insert Colorbox** | `insert_colorbox` | Adds Colorbox‑enabled image styles so inserted images open in a Colorbox lightbox/gallery. |
| **Insert Responsive Image** | `insert_responsive_image` | Adds responsive image styles (`srcset`/`sizes`) as insert options. |

For example:

```bash
drush en insert_media -y
```

Each submodule requires the base Insert module, which is already present once you have
installed it above.

## Verify it worked

After enabling a style on a field (see [Configuration](../configuration/index.md)), edit a
piece of content that uses that field: upload a file or image and confirm an **Insert**
button appears beneath it, then click into the body field and use it.
