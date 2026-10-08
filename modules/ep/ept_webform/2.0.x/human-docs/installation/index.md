# Installation

## Requirements

- **Drupal 10.1, 11, or 12** (`core_version_requirement: ^10.1 || ^11 || ^12`).
- The **EPT Core** module (`ept_core`) — the shared engine for every Extra
  Paragraph Type.
- The **Paragraphs** module (`paragraphs`).
- The **Webform** module (`webform`).

Composer pulls these dependencies in for you when you require the module.

## Install with Composer

From the project root:

```bash
composer require drupal/ept_webform -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ept_webform -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ept_webform -y
```

This also enables EPT Core, Paragraphs and Webform if they are not already on.

## Verify it worked

Edit a piece of content that has a Paragraphs field, add a new paragraph, and
confirm that **EPT Webform** appears in the list of paragraph types. Select it,
choose a webform, and save — the form should render inline. If the paragraph type
is missing, check that the content type's Paragraphs field is configured to allow
the EPT Webform bundle.
