# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No other module dependencies, and no third‑party Composer or PHP library
  requirements.

Optionally, the **Field Group** module if you want to interleave Chunker's page
sections with field-group tabs or accordion panels — that integration is only used
if Field Group is present.

## Install with Composer

From the project root:

```bash
composer require drupal/chunker -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/chunker -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en chunker -y
```

## Verify it worked

Open a bundle's **Manage display** tab. For a long-text field such as **Body**, the
**Format** dropdown should now include the Chunker formatter. Apply it to content
that uses H2/H3 headings and view that content — the page should split into
sections (collapsible, tabbed, or paginated, depending on the formatter settings
you chose).
