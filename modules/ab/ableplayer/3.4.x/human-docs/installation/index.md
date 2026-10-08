# Installation

## Requirements

Able Player needs:

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Media** (`media`) and **Media Library** (`media_library`) modules — Drupal
  enables these automatically as dependencies when you turn on Able Player.

There are no third-party Composer or PHP library requirements. The Able Player
JavaScript itself is bundled inside the module (two small helper assets load from a CDN
at runtime — see the note in the [overview](../index.md)).

## Install with Composer

From the project root:

```bash
composer require drupal/ableplayer -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ableplayer -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ableplayer -y
```

Enabling the module does real work: it creates the caption, description, chapter,
sign-language, and poster fields on your existing audio and video Media types, ships the
**Able Player Caption** media type, and switches the standard local video media to the
Able Player formatter. See the [overview](../index.md#how-to-use-it) for what to do next.

> **Reinstall note:** if you uninstall and reinstall the module, re-save the local video
> media type's *Manage display* form (**Structure → Media types → Video → Manage
> display**) so the Able Player formatter is re-applied.

There are no submodules.
