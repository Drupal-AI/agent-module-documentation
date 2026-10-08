# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement:
  ^8 || ^9 || ^10 || ^11`).
- Core's **Link** field module (`link`), which ships with Drupal and is enabled
  automatically as a dependency.

There are no third‑party Composer or PHP library requirements. The current
release is `8.x-1.x`.

## Install with Composer

From the project root:

```bash
composer require drupal/link_plain_text_formatter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/link_plain_text_formatter -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en link_plain_text_formatter -y
```

## Verify it worked

Go to **Manage display** for an entity that has a link field, open the **Format**
select list for that field, and confirm the new plain‑text Link formatter appears
as an option. Select it, save, and view content — the link should render as plain
text rather than as a clickable anchor.
