# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- No additional modules or libraries — the module states it has no extra
  requirements.
- Core's Field UI is needed to select the widget on *Manage form display*.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_reference_field_autocomplete_filter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/entity_reference_field_autocomplete_filter -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_reference_field_autocomplete_filter -y
```

## Verify it worked

Go to any entity-reference field's **Manage form display**. The **Widget**
dropdown should now offer **Filterable Autocomplete**. Select it, save, then
open an edit form for that bundle — the reference field should show a bundle
select next to the autocomplete input, and choosing a bundle should narrow the
suggestions.
