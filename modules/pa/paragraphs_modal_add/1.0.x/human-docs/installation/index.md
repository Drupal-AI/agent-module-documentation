# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- The **Paragraphs** module (`paragraphs`) — Drupal enables it automatically as a
  dependency when you turn on Paragraphs Modal Add.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/paragraphs_modal_add -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/paragraphs_modal_add -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en paragraphs_modal_add -y
```

That's all — there is no configuration to complete.

## Verify it worked

Edit content that has a Paragraphs field and start adding a paragraph. The add
action should now open in a modal dialog rather than expanding inline. Choose a
paragraph type from the dialog and confirm the new paragraph is added to the form.
