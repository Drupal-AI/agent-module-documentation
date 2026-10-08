# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- The **Paragraphs** module (`paragraphs`), which is the only dependency. Paragraph
  Group 4.x uses the Paragraphs **Stable** widget.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/paragraph_group -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in Paragraphs and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/paragraph_group -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en paragraph_group -y
```

## Verify it worked

Open the Paragraph Group settings page (route `paragraph_group.form`, under
**Configuration**) — it should load. After you enable the features there (see
[Configuration](../configuration/index.md)), edit content that uses paragraphs:
nested paragraphs should now render as collapsible accordion (`<details>`) sections
rather than a flat nested form.
