# Installation

## Requirements

- **Drupal 9, 10 or 11** (`core_version_requirement: ^9 || ^10 || ^11`; Drupal 9 is end-of-life, so 10 or 11 in practice).
- Core's **CKEditor 5** editor, which ships with Drupal core and provides the
  text-editing framework this plugin extends.

There are no third-party Composer packages or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/ckeditor5_show_blocks -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/ckeditor5_show_blocks -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ckeditor5_show_blocks -y
```

## Verify it worked

Edit a text format that uses CKEditor 5 (**Configuration → Content authoring →
Text formats and editors**) and confirm a **Show blocks** button is available to
drag into the active toolbar. Add it, save, then edit a piece of content with
that format and click the button — every block-level element should gain an
outline with its tag name in the corner. See the
[main guide](../index.md#how-to-use-it) for the step-by-step.
