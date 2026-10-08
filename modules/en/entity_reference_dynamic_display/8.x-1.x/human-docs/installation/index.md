# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`). Check
  compatibility before using on Drupal 11.
- No third‑party Composer packages or PHP libraries.
- Core's Field UI is needed to select the formatter on *Manage display*.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_reference_dynamic_display -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/entity_reference_dynamic_display -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_reference_dynamic_display -y
```

## Verify it worked

Go to any entity-reference or Paragraphs field's **Manage display**. The
**Format** dropdown should now include **Dynamic Display**. Selecting it and
opening its settings reveals the override-mode choice (None / target bundle /
delta) and a default view mode — that is the formatter working. See the "How to
use it" section of the [guide](../index.md) for the mapping steps.
