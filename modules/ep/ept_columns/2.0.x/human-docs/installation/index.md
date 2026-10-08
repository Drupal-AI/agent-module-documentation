# Installation

## Requirements

- **Drupal 10.1, 11, or 12** (`core_version_requirement: ^10.1 || ^11 || ^12`).
- **EPT Core** (`ept_core`) and **Paragraphs** (`paragraphs`) — the shared base and
  field system that every Extra Paragraph Types module builds on. (These container
  paragraph types are only useful alongside other paragraph types to nest inside
  them.)

Composer resolves the module's dependencies for you with the command below.

## Install with Composer

From the project root:

```bash
composer require drupal/ept_columns -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and it brings in the EPT base and Paragraphs alongside this
module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ept_columns -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ept_columns -y
```

Drupal will enable `ept_core` and Paragraphs too if they aren't already on.

## Verify it worked

Edit content that has a Paragraphs field allowing the Columns and Container types (or
add such a field first). Add a **Container** or **Columns** paragraph, nest a child
paragraph inside it, and save — the group should render as a structured section. See
the "How to use it" section of the [guide](../index.md) for the nesting‑depth and
revision notes.
