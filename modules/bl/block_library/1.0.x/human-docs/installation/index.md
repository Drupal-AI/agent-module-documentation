# Installation

## Requirements

Block Library builds on Layout Builder, so it needs a couple of modules present:

- **Drupal 9.3+, 10.3+, or 11** (`core_version_requirement: ^9 || ^10 || ^11`;
  the Composer constraint is `drupal/core: ^9.3 || ^10.3 || ^11`).
- Core's **Layout Builder** module (`layout_builder`) — Drupal enables it as a
  dependency.
- **Layout Builder Restrictions** (`layout_builder_restrictions`, `^2.7 || ^3`) —
  a hard dependency; Block Library extends its block picker. Composer pulls it in
  for you.

There are no PHP library requirements, no permissions of its own, and no Drush
commands.

## Install with Composer

From the project root:

```bash
composer require drupal/block_library -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Layout Builder
Restrictions and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/block_library -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en block_library -y
```

This also enables `layout_builder` and `layout_builder_restrictions` if they are
not already on.

## Verify it worked

Edit any custom block type at **Structure → Block content → Block types** — you
should see a new **Icon** section on the form. Once you set an icon there, it
appears next to that block type in Layout Builder's "Add block" picker. See
[Configuration](../configuration/index.md) for the details.
