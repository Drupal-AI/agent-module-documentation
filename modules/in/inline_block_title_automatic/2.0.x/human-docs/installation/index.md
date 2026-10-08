# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- **PHP 8.1 or newer** (`php: ^8.1`).
- Core's **Layout Builder** module (`layout_builder`) enabled — the only dependency,
  and Drupal enables it automatically. Without Layout Builder the module has nothing to
  act on.
- No third-party Composer or PHP libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/inline_block_title_automatic -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/inline_block_title_automatic -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en inline_block_title_automatic -y
```

That's the entire setup. There is no configuration page, no permission, and nothing to
switch on — the behaviour applies everywhere Layout Builder places a content block.

## Verify it worked

On a content type with Layout Builder enabled, edit a node's layout and choose **Add
block**, then add a reusable or inline content block. The **placement label ("Title")**
field and the **Display title** checkbox should be absent from the Add/Configure block
form. (With the module disabled, "Title" would appear as a text field and "Display
title" as a checkbox.)
