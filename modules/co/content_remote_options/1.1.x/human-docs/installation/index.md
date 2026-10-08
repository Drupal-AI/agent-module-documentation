# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- No module dependencies beyond Drupal core, and no third‑party Composer or PHP
  library requirements.
- A reachable **remote endpoint** that returns JSON — this is what supplies the
  field's options. You point the field at it during setup (see the main guide's
  [How to use it](../index.md#how-to-use-it) section).

## Install with Composer

From the project root:

```bash
composer require drupal/content_remote_options -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/content_remote_options -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en content_remote_options -y
```

## Verify it worked

Go to a content type's **Manage fields** screen (**Structure → Content types →
*(your type)* → Manage fields**) and add a field. In the field-type list you
should now see **List (remote options)**. Select it, point it at your JSON
endpoint, and map the value/label keys as described in the main guide's
[How to use it](../index.md#how-to-use-it) section. Then check that a content form
shows the select populated with options from the endpoint.
