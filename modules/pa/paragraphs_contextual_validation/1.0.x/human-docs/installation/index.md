# Installation

## Requirements

- **Drupal core 10.2+ or 11** (`core_version_requirement: ^10.2||^11`).
- **PHP 8.1 or newer.**
- The [Paragraphs](https://www.drupal.org/project/paragraphs) module (`paragraphs`).
- The [Entity Reference Revisions](https://www.drupal.org/project/entity_reference_revisions)
  module (`entity_reference_revisions`) — paragraph reference fields use it.

No external APIs or non‑Drupal libraries are required.

## Install with Composer

From the project root:

```bash
composer require drupal/paragraphs_contextual_validation -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the dependencies
above and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/paragraphs_contextual_validation -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en paragraphs_contextual_validation -y
```

The module creates no new content types, text formats, or config pages — all its
configuration lives on your existing paragraph reference fields.

## Verify it worked

Go to the **Manage fields** page for a content type that has a paragraph reference
field, click **Edit** on that field, and confirm a **Paragraphs contextual
validation** section now appears on the field's edit form. Enable it, add a simple
rule (for example "Hero at most 1 time"), save, then try to save content that
breaks the rule — the save should be blocked with a clear error message.
