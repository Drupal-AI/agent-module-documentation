# Installation

## Requirements

- **Drupal 10.1, 11, or 12** (`core_version_requirement: ^10.1 || ^11 || ^12`).
- Three contrib dependencies, all pulled in automatically by Composer:
  - [**EPT Core**](https://www.drupal.org/project/ept_core) (`drupal/ept_core`
    `^2.0`) — the shared Extra Paragraph Types base (global colors, breakpoints,
    and the `ept_settings` field).
  - [**Paragraphs**](https://www.drupal.org/project/paragraphs)
    (`drupal/paragraphs` `^1.0`) — the Paragraphs system itself.
  - [**jQuery UI Accordion**](https://www.drupal.org/project/jquery_ui_accordion)
    (`drupal/jquery_ui_accordion` `^2.0`) — the front-end accordion library.

There are no permissions to grant and no configuration schema of its own.

## Install with Composer

From the project root:

```bash
composer require drupal/ept_accordion -W
```

The `-W` (`--with-all-dependencies`) flag is important here — it lets Composer pull
in EPT Core, Paragraphs, and jQuery UI Accordion together.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ept_accordion -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ept_accordion -y
```

Enabling it also enables EPT Core, Paragraphs, and jQuery UI Accordion if they are
not already on, and installs the two Accordion Paragraph types as default
configuration. There are no submodules.

## Verify it worked

Add (or reuse) a **Paragraphs** field on a content type, allow the **Accordion**
type in its settings, then create a piece of content and add an Accordion
paragraph. See [How to use it](../index.md#how-to-use-it) in the overview for the
full flow.

> **Uninstalling later?** By design, the Accordion Paragraph types are left in
> place when you uninstall the module, so existing content is not broken.
