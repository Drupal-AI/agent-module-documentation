# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Block** (`block`) and **System** (`system`) modules — both part of Drupal core.

To make use of the Webform and Paragraphs integrations you will also want the contributed
**Webform** and **Paragraphs** modules installed, but the base module itself depends only on
core.

## Install with Composer

Note that the Composer package name differs from the module's machine name. From the project
root:

```bash
composer require drupal/popup_entity_with_integration -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host machine —
> `ddev composer require drupal/popup_entity_with_integration -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

The enabled module's machine name is `popup_form`:

```bash
drush en popup_form -y
```

## Verify it worked

Create a popup entity, give it some content (a block, paragraph, or webform), publish it, and
confirm the modal appears on the front end.
