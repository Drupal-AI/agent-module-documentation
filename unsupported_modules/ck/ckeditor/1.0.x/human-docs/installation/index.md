# Installation

## Requirements

- **Drupal 9.4, 10, or 11** (`core_version_requirement: ^9.4 || ^10 || ^11`).
- Core's **Text Editor** module (`editor`) — the only dependency, enabled
  automatically.
- A **CKEditor 4 Extended Support Model (LTS) license key** to receive security
  patches — this is a paid, commercial key (optional to *install* the module, but
  the whole point of the LTS build). You enter it after enabling; see
  [Configuration](../configuration/index.md).
- The CKEditor 4.25.1-lts JavaScript build is **bundled with the module** — you do
  not download it separately. This module overrides any OSS CKEditor 4 build already
  present.

> **Note the Composer name.** The project is `ckeditor_lts` but the module's machine
> name is `ckeditor` (matching the old core module it replaces).

## Install with Composer

From the project root:

```bash
composer require drupal/ckeditor_lts -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ckeditor_lts -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable it by its **machine name**, `ckeditor`:

```bash
drush en ckeditor -y
```

## Replacing an existing OSS CKEditor 4

If you are swapping this LTS build in for a previously installed open-source
CKEditor 4, you may need to clear the PHP opcode/user cache so the new library and
plugins load. The settings form (see [Configuration](../configuration/index.md))
has an **Advanced → Clear cache** button that flushes APCu/WinCache for this
purpose; the module README also documents a `rebuild.php` route if you lack CLI
APCu access.

Continue to [Configuration](../configuration/index.md) to enter your license key
and attach CKEditor to a text format.
