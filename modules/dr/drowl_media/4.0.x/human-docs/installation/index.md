# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3||^11`).
- Core **Media** (`media`) — the only dependency, enabled automatically.
- For the styling enhancements, use the **Gin** admin theme (preferred) or
  **Claro** (Claro styles are not actively maintained).

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/drowl_media -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/drowl_media -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en drowl_media -y
```

## Submodules — enable only what you need

DROWL Media ships two optional submodules. Enable them individually with
`drush en`:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **DROWL Media Types** | `drowl_media_types` | The ready‑made default media types (such as image and document types) with DROWL's field configuration. |
| **DROWL Media Video** | `drowl_media_video` | Video media handling for the DROWL media setup. |

For example, to add the default media types:

```bash
drush en drowl_media_types -y
```

Each submodule requires the base DROWL Media module, which is already present once
you have installed it above.

## Verify it worked

Go to **Structure → Media types** (`/admin/structure/media`) and confirm the DROWL
media types are present (once you have enabled the relevant submodule). Open the
**Media Library** and you should see the improved styling when using the Gin or
Claro admin theme.
