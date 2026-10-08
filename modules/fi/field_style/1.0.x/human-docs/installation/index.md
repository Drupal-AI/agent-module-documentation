# Installation

## Requirements

- **Drupal 9.4, 10, 11, or 12** (`core_version_requirement: ^9.4 || ^10 || ^11 || ^12`).
- Core's **Field** (`field`), **Node** (`node`), and **Paragraphs**
  (`paragraphs`) modules.

Optional integrations, each unlocking an extra feature:

- **Media** — for picking background images from the Media Library.
- **Token** — for token substitution in CSS selectors (e.g. `.node-[node:nid]`).
- **Image** — for image style support on background images.

## Install with Composer

From the project root:

```bash
composer require drupal/field_style -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/field_style -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en field_style -y
```

## Verify it worked

Add a **Field Style** field to a content type (**Structure → Content types →
*(type)* → Manage fields → Add field**). When you edit content that has the field,
the Field Style editor should appear, with its property groups, breakpoints, and
live CSS preview. See "How to use it" in the [overview](../index.md) for the full
workflow.
