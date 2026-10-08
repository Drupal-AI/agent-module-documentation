# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).
- Core's **CKEditor 5** module (`ckeditor5`), which provides the editor this
  widget extends.

There are no third-party Composer packages or PHP library requirements.

## Install with Composer

The Composer package name follows the project (`ckeditor5_tags`), so:

```bash
composer require drupal/ckeditor5_tags -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/ckeditor5_tags -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

**Watch the name:** the project is `ckeditor5_tags`, but the module's machine
name — the one Drush needs — is `ckeditor_tags`:

```bash
drush en ckeditor_tags -y
```

## Verify it worked

Edit a CKEditor 5 text format (**Configuration → Content authoring → Text formats
and editors**), add the **Dynamic Tags** button to the toolbar, and save. Then
edit some content, insert a dynamic tag, and confirm it appears as a labelled
placeholder widget. See the [main guide](../index.md#how-to-use-it) for the setup
steps — remember that filling the placeholder with a live value requires your own
front-end JavaScript against the `window.dynamicTags` API.
