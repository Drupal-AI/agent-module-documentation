# Installation

## Requirements

- **Drupal 9, 10, 11, or 12** (`core_version_requirement: ^9||^10||^11||^12`).
- The **Paragraphs** module (`paragraphs`) — Drupal enables it automatically as a
  dependency when you turn on Paragraphs List Filter.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/paragraphs_list_filter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/paragraphs_list_filter -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en paragraphs_list_filter -y
```

Note that the machine name you enable is `paragraphs_list_filter`, even though the
project's displayed name is *paragraph_type_list_filter*.

## Verify it worked

Go to where you browse or select paragraph types on a Paragraphs-heavy site. You
should now see filter controls that let you narrow the list by machine name,
label, or description. Enter a value and confirm the list filters down to the
matching paragraph types.
