# Installation

## Requirements

- **Drupal 10.3, 11, or 12** (`core_version_requirement: ^10.3 || ^11 || ^12`).
- Core's **Field** module (`field`) — the only hard dependency.
- No third‑party Composer packages or PHP libraries.
- Paragraph reference support additionally needs the
  [Paragraphs](https://www.drupal.org/project/paragraphs) module if your site
  uses paragraph reference fields.

> **Note:** this module is **not covered** by Drupal's security advisory policy.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_reference_field_hints -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/entity_reference_field_hints -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_reference_field_hints -y
```

## Verify it worked

Go to a bundle's **Manage form display** page and open a supported
entity-reference field's widget settings. You should see a **Show entity
reference field hint** option (plus the optional allowed-bundle and
create-permission toggles). Enable it, save, and open an edit form for that
bundle — a hint listing the allowed bundles should appear below the field. See
the "How to use it" section of the [guide](../index.md) for the full steps.
