# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement:
  ^8 || ^9 || ^10 || ^11`).
- Core's **Link** field module (`link`), which ships with Drupal and is enabled
  automatically as a dependency. No additional contrib modules are required.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/link_title_formatter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/link_title_formatter -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en link_title_formatter -y
```

## Verify it worked

Go to **Manage display** for an entity that has a link field, open the **Format**
select list for that field, and confirm **Link Title Text** appears as an option.
Select it, save, and view content whose link field has a title — you should see
the title rendered as plain text with no clickable anchor.
