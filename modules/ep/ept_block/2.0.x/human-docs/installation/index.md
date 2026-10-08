# Installation

## Requirements

- **Drupal 10.1, 11, or 12** (`core_version_requirement: ^10.1 || ^11 || ^12`).
- **EPT Core** (`ept_core`) and **Paragraphs** (`paragraphs`) — the shared base and
  field system that every Extra Paragraph Types module builds on.
- The **Block Field** (`block_field`) field type, which this paragraph's block
  reference is built on.

Composer resolves the module's dependencies for you with the command below.

## Install with Composer

From the project root:

```bash
composer require drupal/ept_block -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and it brings in the EPT base and Paragraphs alongside this
module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ept_block -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ept_block -y
```

Drupal will enable the EPT base, Paragraphs, and Block Field too if they aren't
already on.

## Verify it worked

Edit content that has a Paragraphs field allowing the Block type (or add such a
field first, remembering to **restrict which blocks it can reference**). Add a
**Block** paragraph, choose a block, and save — the referenced block should render
as its own section in the page. See the "How to use it" section of the
[guide](../index.md) for the permission and caching notes.
