# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- **PHP 8.1** or newer.
- The contrib **Drupal Canvas** module (`drupal/canvas`, `^1.0`) — this module
  enhances Canvas, so Canvas must be present. Composer pulls it in.
- Core's **Filter**, **Editor**, and **CKEditor 5** modules (`filter`, `editor`,
  `ckeditor5`), which Drupal enables as dependencies automatically.

There are no additional PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/canvas_full_html -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update Canvas and other
shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/canvas_full_html -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en canvas_full_html -y
```

Enabling it installs three configuration items for you: the **Canvas Full HTML**
text format, its CKEditor 5 configuration, and the module's single setting (which
starts **on**). There are no submodules.

## Verify it worked

Open a page in Drupal Canvas and edit a rich-text component. The toolbar should
now offer the fuller set of buttons (bold, italic, headings, links, lists, block
quotes, source editing, and so on) rather than Canvas's minimal default. To
adjust it or turn it off, see [Configuration](../configuration/index.md).

## A note before uninstalling

Uninstalling the module **deletes the `canvas_full_html` text format**. If you
have Canvas content saved with that format, switch those components back to a
Canvas default format before uninstalling so they don't lose their format
association.
