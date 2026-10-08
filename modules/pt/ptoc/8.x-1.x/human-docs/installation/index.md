# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Several core modules that the ToC structure is built from, all enabled with it:
  **Block**, **Entity Reference Revisions**, **Field**, **File**, **Image**, and
  **Link**. (Entity Reference Revisions is the module that underpins Paragraphs.)

## Install with Composer

From the project root:

```bash
composer require drupal/ptoc -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the dependencies and
update any shared packages as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ptoc -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ptoc -y
```

## Verify it worked

After enabling, the module's paragraph types, "Table of Contents" view modes, and the
`ptoc_table_of_contents` View block are available. Build a page from paragraphs and
place the **Table of Contents** block on it — see "How it works" on the
[overview page](../index.md) — to confirm the contents list renders with working
jump links.
