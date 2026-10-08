# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- The **Layout Paragraphs** module (`layout_paragraphs`).
- Core's **CKEditor 5** module (`ckeditor5`), which ships with Drupal.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/layout_paragraphs_split -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/layout_paragraphs_split -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en layout_paragraphs_split -y
```

## Verify it worked

Enabling the module is not quite the last step: you still need to add the **Split**
button to a text format's CKEditor 5 toolbar. Go to **Configuration → Content
authoring → Text formats and editors**, edit the format your paragraphs use, drag
the **Split** button into the toolbar, and save. Then edit a Layout Paragraphs
rich‑text paragraph and confirm the Split button appears in the editor toolbar.
See "How to use it" in the [overview](../index.md) for the full walkthrough.
