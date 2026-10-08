# Installation

## Requirements

Paragraphs Inline Entity Form is a bridge module, so it pulls in several other
contrib modules. Version 2.0.x needs:

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11 || ^12`). Drupal
  12 is declared but not usable in practice yet — several dependencies have no
  Drupal 12 release.
- Core's **CKEditor 5** (`ckeditor5`).
- These contrib modules, which Composer installs for you as dependencies:
  - **Paragraphs** (`drupal/paragraphs`, `~1.0`)
  - **Entity Browser** (`drupal/entity_browser`, `^2.9`) and its
    `entity_browser_entity_form` submodule
  - **Embed** (`drupal/embed`, `^1.7`)
  - **Entity Embed** (`drupal/entity_embed`, `^1.5`)
  - **Inline Entity Form** (`drupal/inline_entity_form`, `^1.0 | ^3@rc`)

There are no additional PHP‑library requirements. Note that unlike the 1.x line,
2.0.x no longer requires the Entity API (`drupal/entity`) module.

## Install with Composer

From the project root:

```bash
composer require drupal/paragraphs_inline_entity_form
```

Composer pulls in the whole chain of dependencies above.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/paragraphs_inline_entity_form`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en paragraphs_inline_entity_form -y
```

Enabling it also enables the required modules above and installs the ready‑made
**Paragraphs** embed button and **paragraph_items** entity browser. From here,
follow the three manual setup steps in the [main guide](../index.md#how-to-use-it):
select the embeddable paragraph types on the embed button, add the button to a
CKEditor 5 text format, and grant editors the **Access Paragraph items pages**
permission plus the *use* permission for that text format.

## Optional: the example submodule

To get a working demo (a sample content type and nine paragraph types already
wired up), enable the bundled example:

```bash
drush en paragraphs_inline_entity_form_example -y
```

It's a good way to see the workflow end‑to‑end before configuring your own content
types. It is meant for evaluation and for the module's own tests — don't enable it
on a production site.
