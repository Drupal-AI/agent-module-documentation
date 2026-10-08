# Installation

## Requirements

- **Drupal 10.2, 11, or 12** (`core_version_requirement: ^10.2 || ^11 || ^12`).
- Core **Node**.
- **Paragraphs** (`paragraphs`), **Entity Reference Revisions**
  (`entity_reference_revisions`) and **Field Group** (`field_group`).
- [**Drutopia Core**](../../../drutopia_core/2.0.x/human-docs/index.md)
  (`drutopia_core`) and
  [**Drutopia Page**](../../../drutopia_page/2.0.x/human-docs/index.md)
  (`drutopia_page`).

There are no third-party PHP-library requirements; Composer fetches the Drupal
projects for you.

## Install with Composer

From the project root:

```bash
composer require drupal/drutopia_storyline -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Paragraphs, Field
Group and the Drutopia projects it needs.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/drutopia_storyline -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en drutopia_storyline -y
```

This imports the `storyline_header` and `storyline_item` paragraph types, their
fields and displays, and the `field_storyline` node field storage.

## Submodules

The project ships one optional submodule:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Drutopia Page Storyline** | `drutopia_page_storyline` | Adds the `field_storyline` field to the Drutopia **Page** content type and wires it into the page's form and full view displays, so a Basic page can carry a timeline. |

Enable it only if you want storylines on pages:

```bash
drush en drutopia_page_storyline -y
```

## Verify it worked

Visit **Structure → Paragraphs types** (`/admin/structure/paragraphs_type`) and
confirm the **storyline_header** and **storyline_item** types are listed. If you
enabled the submodule, edit the Page type at
**Structure → Content types → Page** (`/admin/structure/types/manage/page`) and
confirm the storyline field is present.
