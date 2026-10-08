# Installation

## Requirements

- **Drupal 10.1, 11, or 12** (`core_version_requirement: ^10.1 || ^11 || ^12`).
- **EPT Core** (`ept_core`, `^2.0`) — the shared base for all Extra Paragraph Types
  modules, providing the common design options.
- **Paragraphs** (`paragraphs`, `^1.0`).
- Core **Link** (`link`) — a button is a link field with presentation attached.

Composer pulls the contributed dependencies (`ept_core` and Paragraphs) in for you
with the command below.

## Install with Composer

From the project root:

```bash
composer require drupal/ept_basic_button -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and it brings in `ept_core` and Paragraphs alongside this
module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ept_basic_button -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ept_basic_button -y
```

Drupal will enable `ept_core`, Paragraphs, and Link too if they aren't already on.

## Verify it worked

Edit a piece of content that has a Paragraphs field allowing the Basic Button type
(or add such a field first at **Structure → Content types → *(type)* → Manage
fields**). Adding a **Basic Button** paragraph, setting its link, and saving should
render a styled button as its own section. See the "How to use it" section of the
[guide](../index.md) for the full flow.
