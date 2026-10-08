# Installation

## Requirements

- **Drupal 10, 11, or 12** (`core_version_requirement: ^10 || ^11 || ^12`).
- **Drupal core only** — no contrib dependencies. It uses the core **Node** module
  (enabled by default) and core's AJAX dialog / jQuery libraries.
- No third-party PHP or JavaScript libraries.

> **Heads-up:** this module is **not** covered by Drupal's security advisory
> policy. Because the notes are internal, restrict the block to staff.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_note_block -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_note_block -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_note_block -y
```

## Verify it worked

Go to **Structure → Block layout** and place the block labeled **Entity Note
Block**. Visit a page where it appears and click **Add/View Notes** — a modal
should open where you can add a note and see it listed. The first note also
automatically creates the `note_log` content type and its `field_entity_notes`
field, which you can confirm under **Structure → Content types**.
