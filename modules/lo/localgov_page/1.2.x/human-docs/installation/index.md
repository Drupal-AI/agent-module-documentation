# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- A **LocalGov Drupal** site — this content type builds on the LocalGov paragraph
  and media modules and expects the distribution to be present.
- The modules it depends on, which Composer and Drupal pull in automatically:
  core **Node**, **Field**, **Image**, **Menu UI**, **Path** and **Text**;
  **Field Group** (`field_group`); **Paragraphs** (`paragraphs`); **Layout
  Paragraphs** (`layout_paragraphs`); and LocalGov's **Media** (`localgov_media`)
  and **Paragraphs** (`localgov_paragraphs`) modules.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/localgov_page -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install and update the
Paragraphs, Layout Paragraphs and LocalGov dependencies alongside the module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/localgov_page -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en localgov_page -y
```

Drupal enables the Paragraphs, Layout Paragraphs, Field Group and LocalGov
dependencies at the same time.

## Verify it worked

Go to **Content → Add content**. You should see a **Page** type
(`/node/add/localgov_page`). Create one and confirm you can build the body with
**Layout Paragraphs** — adding component blocks from the LocalGov paragraph library
and arranging them into sections.
