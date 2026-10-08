# Installation

## Requirements

- **Drupal 10.1 or newer, or 11** (`core_version_requirement: ^10.1 || ^11`).
- Core's **Field** and **Text** modules, both part of a standard Drupal install.

There are no modules required outside Drupal core, and no third‑party Composer or
PHP library requirements.

> **Release status:** the current release is **2.0.0‑rc1**, a release candidate.
> It's stable enough to evaluate but worth testing on non‑production content first.

## Install with Composer

From the project root:

```bash
composer require drupal/existing_values_autocomplete_widget -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/existing_values_autocomplete_widget -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en existing_values_autocomplete_widget -y
```

## Verify it worked

Go to a content type's **Manage form display** (for example **Structure → Content
types → Article → Manage form display**) and open the widget dropdown for a text
field. You should see **Autocomplete: existing values** as an option. Select it,
save, then create a couple of nodes with different values in that field — when you
edit the next one and start typing, your earlier values should appear as
suggestions. See the "How to use it" section of the [overview](../index.md) for
the full workflow.
