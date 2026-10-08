# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- The **Paragraphs** module (`paragraphs`) — Drupal enables it automatically as a
  dependency when you turn on Paragraphs Paste.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/paragraphs_paste -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/paragraphs_paste -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en paragraphs_paste -y
```

Note this release is a beta and under active development.

## After enabling

Paragraphs Paste is configured per Paragraphs field, not on a central settings
page. Go to your content type's **Manage form display**, enable the paste behavior
for the Paragraphs field, and set how pasted content maps to your paragraph types.
See "How to use it" on the [overview page](../index.md) for the workflow.

## Verify it worked

Edit content with a paste-enabled Paragraphs field and paste some text or a video
link (for example a YouTube URL) into the paste area. The module should
automatically create the appropriate paragraph type(s) from what you pasted.
