# Installation

## Requirements

- **Drupal 10.1, 11, or 12** (`core_version_requirement: ^10.1 || ^11 || ^12`).
- Core's **Views** module (`views`), enabled.
- Several contrib modules, all pulled in by Composer:
  - **EBT Core** (`drupal/ebt_core`, ^2.0) — the shared base for the EBT family.
  - **Paragraphs** (`drupal/paragraphs`, ^1.0) — each tab is a paragraph.
  - **Block Field** (`drupal/block_field`, ^1.0) — for "block" tabs.
  - **Views Reference** (`drupal/viewsreference`, ^2.0) — for "views" tabs.
  - **jQuery UI Tabs** (`drupal/jquery_ui_tabs`, ^2.0) — the front-end tab behaviour.
- At install time the module expects the **Page** content type and the **Media Image** type to
  exist (both come from EBT Core's setup). Install EBT Core first, or install this module with
  `-W` so everything resolves together.

## Install with Composer

From the project root:

```bash
composer require drupal/ebt_tabs -W
```

The `-W` (`--with-all-dependencies`) flag pulls in EBT Core, Paragraphs, Block Field, Views
Reference and jQuery UI Tabs, updating shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host machine —
> `ddev composer require drupal/ebt_tabs -W`, `ddev drush …`. Inside the container
> (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ebt_tabs -y
```

Enabling it also enables its dependencies and installs the *EBT Tabs* block type, the
`ebt_tab` paragraph type and their fields. You can then create Tabs blocks — see **How to use
it** in the [overview](../index.md).
