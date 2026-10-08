# Installation

## Requirements

- **Drupal core 11.4** (`core_version_requirement: ^11.4`).
- **PHP 8.3 or newer.**
- Core's **Field** module (`field`) — the only hard dependency of the core module.
- Additional requirements depend on which submodules you enable:
  - **Entity Reference Deck EB** host — the
    [Entity Browser](https://www.drupal.org/project/entity_browser) module (and
    optionally Entity Browser Multi for multi‑launcher fields).
  - **Entity Reference Deck Paragraphs** host — the
    [Paragraphs](https://www.drupal.org/project/paragraphs) module and
    [Entity Reference Revisions](https://www.drupal.org/project/entity_reference_revisions).
  - **Diff** feature — the [Diff](https://www.drupal.org/project/diff) module.
  - **Usage** feature — the
    [Entity Usage](https://www.drupal.org/project/entity_usage) module.
  - **Paragraphs Library** feature — the Paragraphs host plus Paragraphs Library.
  - **Preview** — the **iframe‑resizer v5** library (see below); it is *not*
    shipped with the module.
  - **Gin** skin — the [Gin](https://www.drupal.org/project/gin) admin theme.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_reference_deck -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. Require the matching contrib packages (Entity Browser,
Paragraphs, Diff, Entity Usage, Gin, …) before enabling the submodules that need
them.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/entity_reference_deck -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable the core module first, then only the submodules you need:

```bash
drush en entity_reference_deck -y
```

## Submodules

Enable these individually, after requiring any contrib packages they depend on:

| Submodule | Machine name | Adds | Needs |
|-----------|--------------|------|-------|
| **Deck EB** (host) | `entity_reference_deck_eb` | Entity Browser field widgets | Entity Browser |
| **Deck Paragraphs** (host) | `entity_reference_deck_paragraphs` | Paragraphs field widget + closed‑row chrome | Paragraphs, Entity Reference Revisions |
| **Deck Diff** (feature) | `entity_reference_deck_diff` | Revision‑compare action + modal | Diff |
| **Deck Usage** (feature) | `entity_reference_deck_usage` | Usage surfaces on cards | Entity Usage |
| **Deck Moderation** (feature) | `entity_reference_deck_moderation` | Content Moderation‑aware card styling | Content Moderation |
| **Deck Paragraphs Library** (feature) | `entity_reference_deck_paragraphs_library` | Library‑item theming | Paragraphs host + Paragraphs Library |
| **Deck Preview** | `entity_reference_deck_preview` | Live front‑end preview in cards | iframe‑resizer (below) |
| **Deck Gin** (skin) | `entity_reference_deck_gin` | Remaps `--erdeck-*` tokens for Gin | Gin theme |

For example, to use it with Paragraphs:

```bash
drush en entity_reference_deck entity_reference_deck_paragraphs -y
```

## Installing iframe‑resizer (only for the Preview submodule)

The **Deck Preview** submodule needs iframe‑resizer v5, which the module does not
bundle. Install it via Asset Packagist so the npm‑asset packages land under
`web/libraries/{$name}`:

```bash
composer require npm-asset/iframe-resizer--parent:^5 npm-asset/iframe-resizer--child:^5
```

The expected files are `/libraries/iframe-resizer--parent/index.umd.js` and
`/libraries/iframe-resizer--child/index.umd.js`. (This requires the Asset
Packagist repository to be configured in your project's `composer.json`.)

## Verify it worked

Go to **Configuration → Content authoring → Entity Reference Deck** — the global
settings form should load. Then, on a bundle's **Manage form display**
(**Structure → Content types → *(type)* → Manage form display**), the entity
reference field should offer an **ER Deck host widget** to select. Set it, save,
and edit content: the referenced items should render as deck cards with the
toolbar actions from whichever feature submodules you enabled.
