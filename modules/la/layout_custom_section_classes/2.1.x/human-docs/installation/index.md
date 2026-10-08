# Installation

## Requirements

- **Drupal 9.5, 10, or 11** (`core_version_requirement: ^9.5 || ^10 || ^11`).
- Core's **Layout Builder** module (`layout_builder`) enabled — the module's whole
  purpose, so it must be on.
- The **`neilime/php-css-lint`** PHP library (`^3.0`), used to validate inline CSS.
  Composer pulls this in automatically when you require the module.

Optionally, the contrib **Token** module — if it is installed, the free-text
attribute fields (ID, classes, styles, `data-*`) accept tokens.

## Install with Composer

From the project root:

```bash
composer require drupal/layout_custom_section_classes -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the bundled
`neilime/php-css-lint` library and update any shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from your
> host machine — `ddev composer require drupal/layout_custom_section_classes -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en layout_custom_section_classes -y
```

## Grant the permissions

The module ships three permissions so you can split responsibilities. Grant them
through **People → Permissions** or with Drush:

| Permission | What it controls |
|---|---|
| **Administer layout builder section classes module settings** | Access to the global settings form. |
| **Administer layout builder section attributes** | Whether a user sees the **section-level** attribute fields in the Configure section form. |
| **Administer layout builder sections region attributes** | Whether a user sees the **region-level** attribute fields in the Configure section form. |

```bash
drush role:perm:add editor 'administer layout builder section attributes'
```

Note that a user also needs the relevant Layout Builder access to reach the
Configure section form at all.

## Verify it worked

Edit an entity or view mode that uses Layout Builder, open a section's **Configure
section** dialog, and confirm the extra attribute fields (ID, classes, styles,
`data-*`) appear. Then head to [Configuration](../configuration/index.md) to decide
which attributes editors may set and to define a predefined class list.
