# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **TOC API** module (`toc_api`) enabled — this is the one required
  dependency, and Composer will pull it in with the command below.
- A **formatted (rich-text) field** on your content type, with text processing
  enabled, to act as the heading source for the table of contents.
- No third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/custom_toc -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including the TOC API module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/custom_toc -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en custom_toc -y
```

This also enables the required `toc_api` module if it isn't already on.

## Verify it worked

Add the **TOC (CKEditor)** field to a content type, point it at a rich-text source
field, then create a node with a few headings and click **Regenerate TOC**. Save
and view the node — the rendered table of contents should appear. See
["How to use it"](../index.md#how-to-use-it) for the full walkthrough.
