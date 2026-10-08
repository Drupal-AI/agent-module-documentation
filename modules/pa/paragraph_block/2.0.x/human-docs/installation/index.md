# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Paragraphs** module (`paragraphs`).
- Core's **Block content** module (`block_content`), used for storage.
- **Form Decorator** (`drupal/form_decorator`) and **Block Form Alter**
  (`drupal/block_form_alter`), which Paragraph Block builds on.
- *(Optional)* core's **Layout Builder** — needed only if you want to place the
  bridged components in Layout Builder layouts.

## Install with Composer

From the project root:

```bash
composer require drupal/paragraph_block -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in Paragraphs, Form
Decorator, Block Form Alter and the other dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/paragraph_block -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en paragraph_block -y
```

If you plan to use Layout Builder, make sure it is enabled too:

```bash
drush en layout_builder -y
```

## Verify it worked

Open **Layout Builder** on a layout‑enabled entity (or **Structure → Block
layout**) and start adding a block. Your existing paragraph types should now appear
as available block types. Place one and confirm it renders — then, before relying
on it, check the translation and nested‑paragraph behaviour described on the
[overview page](../index.md).
