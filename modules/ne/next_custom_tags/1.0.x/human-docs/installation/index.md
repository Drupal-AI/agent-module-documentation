# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Next.js** module (`next:next`) — a required dependency that provides the
  base decoupled integration and the revalidate URL this module uses.
- A configured **Next.js site** entity (set up through the Next.js module) with a
  reachable revalidation endpoint on your Next.js front end.

There are no third‑party PHP library requirements. This module is a developer
tool: it is most useful when you are running a decoupled Next.js front end.

> **Note:** this is a `1.0.0-beta` release and is marked as minimally maintained,
> so review it before relying on it for a production site.

## Install with Composer

From the project root:

```bash
composer require drupal/next_custom_tags -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Next.js
module and any shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/next_custom_tags -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en next_custom_tags -y
```

## Submodules — enable only what you need

Three optional submodules add ready‑made cache‑tag extraction for common entity
types. Enable them individually with `drush en`:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Block** | `next_custom_tags_block` | Cache‑tag extraction for Block Content entities. |
| **Menu** | `next_custom_tags_menu` | Cache‑tag extraction for Menu Link Content entities, so navigation updates immediately when menu links change. |
| **Webform** | `next_custom_tags_webform` | Cache‑tag extraction for Webform entities. |

For example:

```bash
drush en next_custom_tags_menu -y
```

## Verify it worked

Go to **Configuration → Web Services → Next Custom Tags → Plugin configuration**
(`/admin/config/services/next-custom-tags/plugin-settings`). You should see the
list of available plugins with a preview of the example tags each one generates.
Enable the plugins you need, then edit a piece of tracked content and confirm the
matching pages revalidate on your Next.js front end.
