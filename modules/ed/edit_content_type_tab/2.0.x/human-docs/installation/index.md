# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- No third‑party module or PHP library dependencies beyond Drupal core.

## Install with Composer

From the project root:

```bash
composer require drupal/edit_content_type_tab -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/edit_content_type_tab -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en edit_content_type_tab -y
```

Enable this on sites where re‑bundling content is actually required — and where
you can control which roles reach the tab.

## Verify it worked

Confirm it's enabled:

```bash
drush pm:list --status=enabled | grep edit_content_type_tab
```

Then, as a trusted administrator, open a node and look for the new content‑type
tab among the node's local tasks. **Before using it on real content, back up your
database** — this version treats the tab as a content‑type change, which can drop
or remap fields.
