# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 ||
  ^11`).
- Core's **Field** module (`field`).
- For its Paragraphs‑related features the module also declares dependencies on
  **Entity Reference Revisions** (`entity_reference_revisions`), **Paragraphs**
  (`paragraphs`), and **Paragraphs Summary Token** (`paragraphs_summary_token`
  `>= 2.0.2`). Installing Field Fallback with Composer pulls these in
  automatically.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/field_fallback -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Paragraphs
and Entity Reference Revisions dependencies and update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/field_fallback -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en field_fallback -y
```

Drupal will enable the dependency modules at the same time.

## Verify it worked

Edit a field through **Structure → Content types → *(type)* → Manage fields →
*(field)* → Edit** and confirm that a **fallback field** dropdown now appears in
the field settings, listing the other fields that can serve as a fallback. Pick
one, save, then create a piece of content with the primary field left empty and
confirm the fallback value is used in its place.
