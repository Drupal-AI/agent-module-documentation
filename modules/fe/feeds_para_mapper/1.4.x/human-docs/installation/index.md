# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- The **Feeds** module (`drupal/feeds`, `^3.0`) — a hard dependency.
- The **Paragraphs** module (`drupal/paragraphs`) — a hard dependency, which in
  turn brings in **Entity Reference Revisions** (`entity_reference_revisions`).

Composer pulls all of these in automatically. There are no third‑party PHP library
requirements.

Optionally, **Feeds Tamper** (`drupal/feeds_tamper`) is useful for splitting a
single delimited source column into multiple paragraph values (with its "Explode"
transform).

## Install with Composer

From the project root:

```bash
composer require drupal/feeds_para_mapper -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Feeds and
Paragraphs and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/feeds_para_mapper -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en feeds_para_mapper -y
```

Drupal enables **Feeds**, **Paragraphs**, and **Entity Reference Revisions** at the
same time as dependencies.

## Optional: add Feeds Tamper

If you need to explode a delimited cell into several paragraph values:

```bash
composer require drupal/feeds_tamper -W
drush en feeds_tamper -y
```

## Next steps

Enabling the module exposes no page of its own — its effect appears inside the
Feeds mapping UI. Set up (or edit) a Feed Type whose target entity has a Paragraphs
field, then map to the paragraph sub‑fields as described in
[How to use it](../index.md#how-to-use-it).
