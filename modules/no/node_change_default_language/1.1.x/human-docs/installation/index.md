# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- Core's **Node** module (`node`).
- Core's **Language** module (`language`).
- Core's **Content Translation** module (`content_translation`).

Drupal enables these dependencies automatically when you turn on the module. There
are no third‑party Composer packages or PHP library requirements.

> **Optional core patch.** To correctly handle some non‑translatable field cases,
> the project references a Drupal **core patch** (tracked in a core issue). It is not
> required to install the module, but review it if your content relies heavily on
> non‑translatable fields.

## Install with Composer

From the project root:

```bash
composer require drupal/node_change_default_language -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/node_change_default_language -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en node_change_default_language -y
```

## Verify it worked

Make sure you have at least two languages configured and a translatable content
type. Grant the module's *change default language* permission at
**People → Permissions**, then open a translated node's operations dropdown on the
**Content** page — you should see **Change default language**, or you can visit
`/node/{nid}/change-default-language` directly. See the
[overview](../index.md) for the full usage walkthrough.
