# Installation

## Requirements

- **Drupal 10.2, 11, or 12** (`core_version_requirement: ^10.2 || ^11 || ^12`).
- **Paragraphs** (`paragraphs`) and **Entity Reference Revisions**
  (`entity_reference_revisions`).
- **Allowed Formats** (`allowed_formats`) — constrains the title/subtitle text
  formats.
- **UI Patterns** (`ui_patterns`) — renders the paragraph as a component.
- [**Drutopia Core**](../../../drutopia_core/2.0.x/human-docs/index.md)
  (`drutopia_core`).

There are no third-party PHP-library requirements; Composer fetches the Drupal
projects for you.

## Install with Composer

From the project root:

```bash
composer require drupal/drutopia_paragraph_title -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Paragraphs, UI
Patterns and the other required projects.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/drutopia_paragraph_title -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en drutopia_paragraph_title -y
```

This imports the **title** paragraph type, its fields and displays, and the Twig
templates that theme it.

## Verify it worked

Visit **Structure → Paragraphs types** (`/admin/structure/paragraphs_type`) and
confirm the **title** type is listed with its title, subtitle, style/colour and
image fields. Then add the paragraph to a content type's Paragraphs field and
check that it renders as a styled header.
