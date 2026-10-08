# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Filter** module (`filter`), which provides the text-format system this
  filter plugs into. Drupal enables it automatically as a dependency.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/hanging_conjunctions_filter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/hanging_conjunctions_filter -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en hanging_conjunctions_filter -y
```

Enabling the module makes the filter *available*; it doesn't do anything until you
switch it on for a text format — see the
[main guide](../index.md#how-to-use-it).

## Verify it worked

1. Enable the filter on a text format (see the main guide) and place it after the
   HTML-correcting filters.
2. Create Polish-language content that ends a line with a single-letter word (such
   as *w* or *i*) using that format.
3. View the rendered output and confirm a non-breaking space now keeps the
   single-letter word attached to the following word instead of stranding it at the
   end of the line. Use the text format's preview/test feature to check the effect
   before relying on it widely.
