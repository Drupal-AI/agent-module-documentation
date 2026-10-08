# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3||^11`).
- Core's **Field UI** module enabled — this is what provides the *Manage form
  display* interface that Form layout extends.
- **Paragraphs** is optional but recommended if you want nested layouts inside
  Paragraphs widgets.

There are no third‑party Composer or PHP library requirements, and the module is
covered by Drupal's security advisory policy.

## Install with Composer

From the project root:

```bash
composer require drupal/form_layout -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/form_layout -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en form_layout -y
```

If Field UI is not already on, enable it too:

```bash
drush en field_ui -y
```

## Verify it worked

Log in as an administrator and go to **Configuration → Content authoring → Form
layout**. If you can pick which entity types should have layout functionality,
the module is installed. Next, turn it on for an entity type and start grouping
fields — see [Configuration](../configuration/index.md).
