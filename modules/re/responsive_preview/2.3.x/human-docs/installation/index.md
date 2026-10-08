# Installation

## Requirements

- **Drupal 10.5 or 11** (`core_version_requirement: ^10.5 || ^11`).
- No module dependencies and no third‑party PHP libraries. The preview control
  appears in the core Toolbar, so you'll want core's Toolbar (or, with the
  optional submodule, the core Navigation) available.

## Install with Composer

From the project root:

```bash
composer require drupal/responsive_preview -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/responsive_preview -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en responsive_preview -y
```

Enabling the module installs the four default devices (Phone, Tablet Portrait,
Tablet Landscape, Desktop).

## Grant the permissions

Responsive Preview defines two permissions at **People → Permissions**:

- **Access responsive preview** — lets a user actually use the toolbar control
  and block. Content editors typically get this one.
- **Administer responsive preview** — lets a user manage the device definitions.
  Give this to site builders.

Grant them from Drush, for example:

```bash
drush role:perm:add editor 'access responsive preview'
```

## Submodule — enable only if you need it

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Responsive Preview Navigation** | `responsive_preview_navigation` | Surfaces the responsive‑preview icons in Drupal's newer core Navigation top bar (instead of the classic Toolbar). |

```bash
drush en responsive_preview_navigation -y
```

## Next step

To customize the device list or add your own presets, see
[Configuration](../configuration/index.md).
