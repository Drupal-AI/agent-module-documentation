# Installation

## Requirements

- **Drupal 10.1, 11, or 12** (`core_version_requirement: ^10.1 || ^11 || ^12`).
- **EBT Core** (`ebt_core`) — the shared base for the Extra Block Types family.
- **Views Reference** (`viewsreference`) — supplies the field that picks the view and
  display.
- Core **Views**, which is enabled on most sites already.

Composer resolves these automatically when you install with the `-W` flag below.
There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/ebt_views -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ebt_views -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ebt_views -y
```

Enabling the module installs the **EBT Views** block type with its Views Reference
field, an optional body field, and the shared EBT settings field.

## Verify it worked

Go to **Content → Blocks → Add content block** — you should see **EBT Views** as an
available block type. Add one, select a view and display, place it, and confirm the
view's results render inside the EBT‑styled block.
