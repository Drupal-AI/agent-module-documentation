# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8||^9||^10||^11`).
- No other module dependencies and no third-party PHP libraries. (The format
  relies on WYSIWYG Linebreaks behaviour, which ships with the module's
  configuration.)

## Install with Composer

From the project root:

```bash
composer require drupal/minimalhtml -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/minimalhtml -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en minimalhtml -y
```

Enabling the module creates the **Minimal HTML** text format, ready to select on
any text area.

## Submodules

Minimal HTML ships one optional submodule:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Minimal HTML Title** | `minimalhtmltitle` | An even more restricted text format intended for title-style text. It works independently of the main module, so you can enable it on its own or alongside Minimal HTML. |

Enable it if you need the title format:

```bash
drush en minimalhtmltitle -y
```

## Verify it worked

Go to **Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`). You should see **Minimal HTML** (and **Minimal
HTML Title** if you enabled the submodule) in the list of available formats. Select
it beneath any text field that should offer limited, safe formatting.
