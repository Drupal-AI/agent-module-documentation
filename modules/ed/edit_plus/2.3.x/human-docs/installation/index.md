# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- Two module dependencies, both pulled in by Composer:
  - [Tempstore Plus](https://www.drupal.org/project/tempstore_plus)
    (`tempstore_plus`)
  - [Twig Events](https://www.drupal.org/project/twig_events) (`twig_events`)
- No additional PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/edit_plus -W
```

The `-W` flag lets Composer bring in Tempstore Plus and Twig Events alongside
Edit +.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/edit_plus -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en edit_plus -y
```

This also enables the Tempstore Plus and Twig Events dependencies.

## Submodules — enable only what you need

Edit + ships a set of optional submodules for building blocks and landing pages.
Enable the ones that match what you're building:

| Submodule | What it adds |
|-----------|--------------|
| `edit_plus_cta_block` | An inline‑editable call‑to‑action block. |
| `edit_plus_header_block` | An inline‑editable header block. |
| `edit_plus_image_block` | An inline‑editable image block. |
| `edit_plus_teaser_block` | An inline‑editable teaser block. |
| `edit_plus_layout_block` | A layout block for structuring inline‑edited content. |
| `edit_plus_landing_page` | A landing‑page building experience. |
| `edit_plus_lb` | Layout Builder integration. |
| `edit_plus_non_lb_node` | Inline editing for nodes not using Layout Builder. |

For example:

```bash
drush en edit_plus_lb edit_plus_cta_block -y
```

## Verify it worked

Confirm the base module and its dependencies are on:

```bash
drush pm:list --status=enabled | grep -E 'edit_plus|tempstore_plus|twig_events'
```

Then grant the **Edit +** permissions to your editor roles at **People →
Permissions**, browse to a page as one of those users, and enter **Edit Mode** to
use the **Change** tool. Remember that inline editing respects the underlying
entity/field edit access — verify your permissions before relying on it.
