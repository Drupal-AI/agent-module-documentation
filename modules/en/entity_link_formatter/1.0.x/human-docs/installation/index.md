# Installation

## Requirements

Entity Link Formatter is lightweight:

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No module dependencies, and no third-party PHP or JavaScript libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_link_formatter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_link_formatter -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_link_formatter -y
```

## Verify it worked

Go to any bundle that has an **entity reference** field (**Structure → Content
types → *(your type)* → Manage display**). Open that field's format dropdown — the
Entity Link formatter should now be listed as an option. Select it, configure the
link template and link text, and save. The reference now renders as a link on the
entity's display.
