# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The [Paragraphs](https://www.drupal.org/project/paragraphs) module (`paragraphs`)
  — the only dependency.

There are no third‑party Composer or PHP library requirements.

> **Status note:** this project is **not covered by Drupal's security advisory
> policy**. Evaluate it with that in mind.

## Install with Composer

From the project root:

```bash
composer require drupal/paragraphs_field_validator -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/paragraphs_field_validator -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en paragraphs_field_validator -y
```

## Verify it worked

Go to **Configuration → Content authoring → Paragraphs Field Validator** and
confirm the settings form loads. Add a simple rule (see
[Configuration](../configuration/index.md)), then edit content whose paragraph
matches the trigger condition and enter a value that breaks the pattern — the save
should be blocked with your error message.
