# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- No third-party Composer libraries and no hard module dependencies for the base
  module. For the Media Library integration you enable the bundled **`ib_dam_media`**
  submodule, which builds on core **Media** / **Media Library**.
- A working **IntelligenceBank account** with credentials/SSO — the module can't do
  anything useful without a real platform to connect to.

> **Note the package name.** The project/Composer name is **`drupal/intelligencebank`**,
> but the module machine name you enable is **`ib_dam`**.

## Install with Composer

From the project root:

```bash
composer require drupal/intelligencebank -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/intelligencebank -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable the base module and, in almost all cases, the Media Library integration:

```bash
drush en ib_dam ib_dam_media -y
```

- **`ib_dam`** — the base module (settings form, services, asset model, asset
  validation). On its own it does little that editors see.
- **`ib_dam_media`** — adds the `ib_dam_embed` Media source/type and the in-modal
  IntelligenceBank asset browser inside the core Media Library. This is the piece
  that gives editors a way to pick IB assets.

## Submodules — what to enable

| Submodule | Machine name | Enable it? |
|-----------|--------------|------------|
| **Media integration** | `ib_dam_media` | Yes — the main integration surface (Media Library asset browser, media source/type). |
| **WYSIWYG (legacy)** | `ib_dam_wysiwyg` | No — a **deprecated** legacy CKEditor filter that is a no-op in 5.x and removed in 6.0. Don't enable it on new sites. |

## Next steps

After enabling, configure the connection on the settings form and grant the
permission — see [Configuration](../configuration/index.md).
