# Installation

## Requirements

- **Drupal 10, 11, or 12** (`core_version_requirement: ^10 || ^11 || ^12`).
- Core's **CKEditor 5** module (`ckeditor5`) enabled — this is the only
  dependency.

There are no third‑party Composer or PHP library requirements — the plugin needs
no external libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/ckeditor5_definition_list_fix -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ckeditor5_definition_list_fix -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ckeditor5_definition_list_fix -y
```

Then enable the **Definition List Fix Plugin** on the CKEditor 5 text formats where
you want it (see the "How to use it" section of the [overview](../index.md)).

## Verify it worked

In a text format with the plugin enabled, create a definition list (`<dl>` with
`<dt>` terms and `<dd>` descriptions) — using Source editing if needed — then save
and reopen the content. The definition-list markup should be preserved, with no
stray `<p>` tags inserted inside the terms or descriptions.
