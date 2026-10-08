# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Field** module (`field`), which is part of a standard Drupal install
  and is enabled automatically as a dependency.
- **Developer knowledge:** to make the field useful you need to write a small
  custom module implementing two hooks (see the module's "How to use it").

## Install with Composer

From the project root:

```bash
composer require drupal/overview_field -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/overview_field -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en overview_field -y
```

## Submodules

Overview Field ships one optional submodule:

| Submodule | Machine name | What it does |
|-----------|--------------|--------------|
| **Overview Field Example** | `overview_field_example` | A worked example implementing both hooks (`hook_overview_field_options_alter()` and `hook_overview_field_output_alter()`). Enable it to see a real option in the select widget and to use its code as a template. |

```bash
drush en overview_field_example -y
```

## Verify it worked

Add an **Overview** field to any content type under **Structure → Content types →
*(type)* → Manage fields**. On a node edit form the field appears as a select list
with a "No overview" option. Until a module registers options via the hook, the
list will only contain that empty option — enable `overview_field_example` (or
implement the hook yourself) to see real choices.
