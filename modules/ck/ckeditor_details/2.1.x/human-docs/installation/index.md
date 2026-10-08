# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- Core's **CKEditor 5** module — the accordion button is a CKEditor 5 plugin. (The module
  also carries legacy CKEditor 4 support for older/migrated formats.)

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/ckeditor_details -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ckeditor_details -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ckeditor_details -y
```

There are no submodules and no settings page. To make the accordion button available,
add the **Detail** button to a CKEditor 5 text format's toolbar — see
[How to use it](../index.md#how-to-use-it) on the overview page.

## Verify it worked

Open a content form that uses a CKEditor 5 format you added the button to. You should see
an **Add accordion** button in the toolbar; clicking it inserts a collapsible
`<details>`/`<summary>` block that expands and collapses on click.
