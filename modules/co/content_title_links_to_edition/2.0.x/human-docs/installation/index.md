# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- Core **Node** (`node`) and **Views** (`views`) modules — both standard on a
  typical site, and Drupal enables them as dependencies.
- No third‑party Composer packages or external libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/content_title_links_to_edition -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/content_title_links_to_edition -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en content_title_links_to_edition -y
```

## Verify it worked

Enable the "link the title to the edit form" option on your content listing
(see "How to use it" in the [overview](../index.md)), then, as a user with edit
access, open the listing and click a title — you should land on that node's edit
form rather than its published page. As a user *without* edit access to the same
content, confirm the title does not become an edit shortcut, which shows the
edit‑access check is working.
