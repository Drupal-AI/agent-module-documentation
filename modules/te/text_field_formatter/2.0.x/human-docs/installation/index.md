# Installation

## Requirements

- **Drupal 8 or newer** (`core_version_requirement: >=8`).
- No third‑party Composer packages, PHP libraries or other module dependencies —
  it builds only on core's String formatter.

## Install with Composer

From the project root:

```bash
composer require drupal/text_field_formatter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/text_field_formatter -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en text_field_formatter -y
```

There is **no configuration form, no permissions and no submodules**. Once
enabled, the **"Text field formatter"** format becomes available on any plain
text (string) field — see [How to use it](../index.md#how-to-use-it).

## Verify it worked

On a bundle that has a plain text (string) field, open **Manage display** and
confirm that **"Text field formatter"** appears in that field's **Format**
dropdown.
