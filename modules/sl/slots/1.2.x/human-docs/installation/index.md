# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Three contrib module dependencies, all pulled in by Composer:
  - **Block plugin view builder** (`block_plugin_view_builder`) — renders the
    matched blocks into the slots.
  - **Conditions** (`conditions`), specifically its **`conditions_field`**
    submodule — the reusable condition system that decides which content shows
    in which slot.
  - **Dynamic Entity Reference** (`dynamic_entity_reference`).

## Install with Composer

From the project root:

```bash
composer require drupal/slots -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the required
dependencies (Block plugin view builder, Conditions, Dynamic Entity Reference)
and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/slots -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en slots -y
```

Enable the `conditions_field` submodule alongside it if it is not already on.

## Submodules — enable only the integrations you need

Slots ships optional submodules that extend *where* you can place a slot. Enable
whichever match how you build pages:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Slots Paragraphs** | `slots_paragraphs` | Lets you add a slot inside a Paragraph. |
| **Slots Views** | `slots_views` | Lets you add a slot to a View's header or footer. |
| **Slots Twig** | `slots_twig` | Adds a `slot()` Twig function so you can place a slot directly in a template with `{{ slot(slot_id, cardinality) }}`. |

For example:

```bash
drush en slots_twig -y
```

## Verify it worked

Once enabled, visit **Content → Slots** (`/admin/content/slots`) — the slot
overview should load for a user with the right permissions. Then follow
[Configuration](../configuration/index.md) to place your first slot and fill it
with content.
