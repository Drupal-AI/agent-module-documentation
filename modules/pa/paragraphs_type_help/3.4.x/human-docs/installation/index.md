# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Paragraphs** module (`drupal/paragraphs`) — this module extends Paragraph
  types, so it can't work without it.
- Core **Image** (`image`), **Options** (`options`), and **Text** (`text`) modules —
  enabled automatically as dependencies.

**Suggested (optional):** the **Field Group** module (`drupal/field_group`), which lets
you tidy the Paragraph edit form by wrapping the help in a collapsible "Need Help?"
fieldset.

There are no third-party Composer or PHP library requirements beyond those modules.

## Install with Composer

From the project root:

```bash
composer require drupal/paragraphs_type_help -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the Paragraphs
dependency and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/paragraphs_type_help -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en paragraphs_type_help -y
```

## After enabling

No help shows until you create some. Grant the permissions to the right roles, then
create your first help item — see [Configuration](../configuration/index.md).
