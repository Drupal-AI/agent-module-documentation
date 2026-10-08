# Installation

## Requirements

- **Drupal 10.5 or 11** (`core_version_requirement: ^10.5 || ^11`).
- Core's **Options** module (`options`) — the only dependency, enabled
  automatically as a dependency when you turn on Icons.

There are no third‑party Composer or PHP library requirements for the base
module. Individual provider submodules expect their own icon library assets (for
example an IcoMoon or Fontello export) to be available on the site.

## Install with Composer

From the project root:

```bash
composer require drupal/icons -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/icons -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable the base API module:

```bash
drush en icons -y
```

## Submodules — enable the providers you use

Icons ships one submodule per provider. Enable only the ones you need — each
brings its own library expectations:

| Submodule | Machine name | Provides |
|-----------|--------------|----------|
| **Font Awesome** | `icons_fontawesome` | Font Awesome icons |
| **Fontello** | `icons_fontello` | Fontello icon sets |
| **IcoMoon** | `icons_icomoon` | IcoMoon icon sets |
| **Icon picker** | `icons_iconpicker` | A generic icon‑picker widget |

For example, to enable the IcoMoon provider:

```bash
drush en icons_icomoon -y
```

Each submodule requires the base Icons module, which is already present once you
have installed it above.

## Verify it worked

Enable the base module and at least one provider submodule, make the library's
icon assets available, and confirm you can create/see the icon set the provider
adds and pick icons where it exposes them (for example on a menu link). See the
[main guide](../index.md#how-to-use-it) for the end‑to‑end flow.
