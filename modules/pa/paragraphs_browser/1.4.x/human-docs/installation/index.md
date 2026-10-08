# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`). Drupal 9 and
  10.0/10.1 are no longer supported by this branch.
- The **Paragraphs** module (`drupal/paragraphs`) — a hard dependency, pulled in
  by Composer. Paragraphs in turn depends on Entity Reference Revisions.
- Core's **System** module (always present).
- At least one paragraph type and a Paragraphs (entity reference revisions) field
  on some content type, so there is something for the browser to organise.

There are no third‑party Composer or PHP library requirements beyond what
Paragraphs brings.

## Install with Composer

From the project root:

```bash
composer require drupal/paragraphs_browser -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including pulling in the required **Paragraphs** module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/paragraphs_browser -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en paragraphs_browser -y
```

This enables Paragraphs Browser and, if it isn't already on, the **Paragraphs**
module too. You can also enable them from **Extend** (`/admin/modules`).

The module ships a default "Content" browser type to get you started.

## Upgrading from 1.3.x

Run database updates after updating the code:

```bash
drush updatedb -y
```

Update `paragraphs_browser_update_8001` moves any preview description you had set
under the old Paragraphs Browser settings into each paragraph type's own
**description** field (only when that description was empty), matching the new
behaviour where the card text comes from the paragraph type's native description.

## Next steps

Build a browser, add groups, assign your paragraph types, and switch the widget
on for a field — see [Configuration](../configuration/index.md).
