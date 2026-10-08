# Installation

## Requirements

File Browser stands on several other modules and a few JavaScript libraries.

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Contributed modules, pulled in automatically by Composer:
  - **Entity Browser** (`drupal/entity_browser`, `^2 || ^1`)
  - **Entity Embed** (`drupal/entity_embed`, `^1`)
  - **DropzoneJS** (`drupal/dropzonejs`, `^2`, including its
    `dropzonejs_eb_widget` submodule)
  - **Embed** (`drupal/embed`, `^1`)
- Core modules it uses: **Field**, **File**, **Image**, **Views**, **Node**,
  **Menu UI**, **Path**, and **Text** (all standard in a normal Drupal install).
- Front‑end JavaScript libraries loaded from `/libraries`: **Masonry**,
  **imagesLoaded**, **Backbone**, and **Underscore**.

## Install with Composer

From the project root:

```bash
composer require drupal/file_browser -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in and update the
required contributed modules (Entity Browser, Entity Embed, DropzoneJS, Embed)
and any shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/file_browser -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

### Provide the JavaScript libraries

File Browser needs Masonry, imagesLoaded, Backbone, and Underscore present in the
site's `/libraries` directory. The module ships a `composer.libraries.json` you
can merge (via the Wikimedia composer‑merge‑plugin) so Composer downloads them,
or you can download them into `/libraries` manually. Without these libraries the
thumbnail grid will not render correctly.

## Enable the module

```bash
drush en file_browser -y
```

Enabling the module also enables its dependencies and installs the ready‑made
Entity Browser, View, image styles, and Embed button. Next, attach the **Browser
for files** to a field's form widget — see the **How to use it** section on the
[overview page](../index.md).

## Submodule

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **File Browser Example** | `file_browser_example` | A working, pre‑wired demo — a block and field already set up to use the browser, so you can see the whole thing in action. |

```bash
drush en file_browser_example -y
```
