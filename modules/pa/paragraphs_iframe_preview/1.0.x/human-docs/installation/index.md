# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- The **Paragraphs** module (`paragraphs`) — Drupal enables it automatically as a
  dependency when you turn on Paragraphs iFrame Preview.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/paragraphs_iframe_preview -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/paragraphs_iframe_preview -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en paragraphs_iframe_preview -y
```

## Verify it worked

Go to a content type's **Manage form display**, open your Paragraphs field's
settings, and set **Closed / collapsed mode** to **Preview**. Then edit a piece
of content, collapse a paragraph, and confirm the preview now renders with your
front-end theme inside an iframe rather than in the admin theme. See "How to use
it" on the [overview page](../index.md) for the recommended form-display settings.
