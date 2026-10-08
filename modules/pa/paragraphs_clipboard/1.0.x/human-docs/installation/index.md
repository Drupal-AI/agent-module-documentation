# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- The **Paragraphs** module (`drupal/paragraphs`, `^1.17`) — a hard dependency.
  Install it if you don't already have it.

There are no third‑party Composer or PHP library requirements.

### Optional companions

These aren't required, but they enhance the module:

- **Replicate** (`drupal/replicate`) — used for deep, reference‑safe cloning of
  complex/nested paragraphs. Without it, the module falls back to Drupal's built‑in
  duplication.
- **Paragraphs Edit** (`drupal/paragraphs_edit`) — adds the *Copy to clipboard*
  link on paragraphs as rendered on the page.
- **Layout Paragraphs** (`drupal/layout_paragraphs`) — enable the bundled
  **Layout Paragraphs Clipboard** submodule to bring copy/paste to the Layout
  Paragraphs builder.

## Install with Composer

From the project root:

```bash
composer require drupal/paragraphs_clipboard -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install Paragraphs and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/paragraphs_clipboard -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en paragraphs_clipboard -y
```

Drupal enables Paragraphs as a dependency at the same time.

### Optional submodule — Layout Paragraphs Clipboard

If you use the Layout Paragraphs builder and want copy/paste there too, enable the
bundled submodule (Layout Paragraphs must be installed):

```bash
drush en layout_paragraphs_clipboard -y
```

## Verify it worked

Edit a piece of content that uses a Paragraphs field. On any **saved** paragraph,
open its actions dropdown — you should see **Copy to clipboard**. There is no
configuration to do. See the [overview page](../index.md#how-to-use-it) for the
full copy/paste walkthrough.
