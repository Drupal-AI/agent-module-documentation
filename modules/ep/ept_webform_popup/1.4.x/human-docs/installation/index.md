# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- The **EPT Basic Button** module (`ept_basic_button`) — this paragraph builds on
  the EPT button, which in turn brings in EPT Core.
- The **Paragraphs** module (`paragraphs`).
- The **Webform** module (`webform`).

Composer pulls these dependencies in for you when you require the module.

## Install with Composer

From the project root:

```bash
composer require drupal/ept_webform_popup -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ept_webform_popup -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ept_webform_popup -y
```

This also enables EPT Basic Button, Paragraphs and Webform (and EPT Core) if they
are not already on.

## Verify it worked

Edit a piece of content that has a Paragraphs field, add a new paragraph, and
confirm that **EPT Webform Popup** appears in the list of paragraph types. Set a
button label, choose a webform, and save — the rendered page should show the button,
and clicking it should open the form in a modal.
