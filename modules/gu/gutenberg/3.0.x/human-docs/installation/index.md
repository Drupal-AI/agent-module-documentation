# Installation

## Requirements

Gutenberg leans on a broad set of core modules but no third‑party services. It needs:

- **Drupal 9.5, 10, or 11** (`core_version_requirement: ^9.5 || ^10 || ^11`).
- **PHP 7.4 or newer** and the PHP **JSON** extension (`ext-json`).
- A number of core modules, all of which ship with Drupal and are enabled
  automatically as dependencies: **Editor**, **Node**, **Views**, **User**, **Block
  Content**, **Image**, **File**, **Filter**, **Options**, and **Taxonomy**.

There are no external Composer libraries to add — the editor's JavaScript is bundled
with the module.

## Install with Composer

From the project root:

```bash
composer require drupal/gutenberg -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/gutenberg -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en gutenberg -y
```

Enabling it also turns on the core dependencies above and installs the `gutenberg`
text format and its paired editor.

## Grant the permissions

At **People → Permissions** (`/admin/people/permissions`), grant Gutenberg's three
permissions to the appropriate roles:

- **Use Gutenberg** — required to author with the block editor and to reach the
  editor's media/block/oEmbed routes. Give this to any role that should write
  Gutenberg content.
- **Manage blocks lock** — lets a user manage block locking within the editor.
- **Create and edit custom gutenberg content blocks** — lets a user build custom
  (non‑reusable) content blocks inline.

Note there is no separate "administer Gutenberg" permission; enabling it on a content
type uses the usual **Administer content types** permission.

## Optional submodule

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Example Blocks** | `example_blocks` | Sample custom blocks demonstrating how to register your own editor blocks. Enable it only if you want the examples as a reference. |

```bash
drush en example_blocks -y
```

## Verify it worked

Continue to [Configuration](../configuration/index.md), enable Gutenberg on a content
type, and add a piece of content of that type — you should land in the full‑screen
block editor instead of the standard node form.
