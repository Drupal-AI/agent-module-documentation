# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`; it also declares compatibility
  with the upcoming Drupal 12).
- The [Paragraphs](https://www.drupal.org/project/paragraphs) module (`paragraphs`)
  — the only dependency.

There are no third‑party Composer or PHP library requirements.

> **Status note:** this project is **not covered by Drupal's security advisory
> policy** and is described as minimally maintained. Evaluate it with that in mind.

## Install with Composer

From the project root:

```bash
composer require drupal/paragraphs_em -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/paragraphs_em -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en paragraphs_em -y
```

## Verify it worked

Make sure a Paragraphs field's widget uses the **modal** add method (on the
entity's Manage form display), then edit a piece of content with that field and add
a paragraph. The add dialog should show the extended, categorized modal layout
rather than the plain default one.
