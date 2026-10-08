# Installation

## Requirements

- **Drupal 10.3, 11, or 12** (`core_version_requirement: ^10.3 || ^11 || ^12`).
- **PHP 8.2** or newer.
- Core's **System** and **Field** modules — both part of Drupal core and already
  present. The module also uses core's `drupal.dialog.ajax` library and the
  `#[Hook]` attribute system.

There are **no contributed dependencies and no external libraries**. In
particular, this module does *not* require the `inline_entity_form` module — it is
a standalone replacement.

## Install with Composer

From the project root:

```bash
composer require drupal/inline_entity_form_dialog -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/inline_entity_form_dialog -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en inline_entity_form_dialog -y
```

There is no global configuration to complete after enabling. You wire the widget
up per field on **Manage form display** — see [How to use it](../index.md#how-to-use-it).

## Verify it worked

Go to **Structure → Content types → *(a type with an entity‑reference field)* →
Manage form display**. Open the widget dropdown for that reference field — you
should now see **Inline Entity Form Dialog** as an option. Choose it, save, then
edit a piece of content and confirm the field shows **Add** / **Edit** buttons
that open a modal.
