# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Language** module (`language`), enabled automatically as a dependency.
  For the formatters to be meaningful you'll also want translatable content, which
  in practice means core's Content Translation set up on the relevant entity types.

There are no third‑party Composer or PHP library requirements.

> **Alpha software.** This is version 2.1.0‑alpha1, and it overrides core's node
> view builder to work around a core issue. Test it on a non‑production environment
> against your Drupal version before relying on it.

## Install with Composer

From the project root:

```bash
composer require drupal/language_display -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/language_display -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en language_display -y
```

## Verify it worked

Go to a translatable content type's **Manage display** (**Structure → Content types
→ *(type)* → Manage display**). The language field's format options should now
include **Original language** and **Original language with translation counter** —
assign one and view a piece of translated content to see it in action. See "How to
use it" in the [overview](../index.md).
