# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- The **Allowed Formats** module (`allowed_formats`) — a hard dependency.
- The **Paragraphs** module (`paragraphs`) — a hard dependency.
- Core's **Field** and **Text** modules (part of Drupal core).

Dependencies are enabled automatically when you enable this module. There are no
third‑party Composer or PHP library requirements beyond the contrib modules
above.

## Install with Composer

From the project root:

```bash
composer require drupal/paragraphs_wysiwyg -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Allowed Formats,
Paragraphs, and any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/paragraphs_wysiwyg -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en paragraphs_wysiwyg -y
```

Drupal will enable Allowed Formats and Paragraphs automatically if they are not
already on.

## Verify it worked

Confirm the module is enabled at **Extend** (`/admin/modules`). Then check that
you can embed paragraphs inline within a rich‑text field on your content, and that
the text format used sanitizes its output.
