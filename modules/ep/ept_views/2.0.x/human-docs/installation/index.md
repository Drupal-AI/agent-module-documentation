# Installation

## Requirements

- **Drupal 10.1, 11, or 12** (`core_version_requirement: ^10.1 || ^11 || ^12`).
- The **EPT Core** module (`ept_core`) — the shared engine for every Extra
  Paragraph Type.
- The **Paragraphs** module (`paragraphs`).
- The **Views** module (core) enabled, since this paragraph embeds views.

Composer pulls the EPT Core and Paragraphs dependencies in for you when you
require the module.

## Install with Composer

From the project root:

```bash
composer require drupal/ept_views -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ept_views -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ept_views -y
```

This also enables EPT Core and Paragraphs if they are not already on.

## Verify it worked

Edit a piece of content that has a Paragraphs field, add a new paragraph, and
confirm that **EPT Views** appears in the list of paragraph types you can add.
Select it, choose a view, and save — the view should render inline. If the
paragraph type is missing, check that the content type's Paragraphs field is
configured to allow the EPT Views bundle.
