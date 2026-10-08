# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).
- The **Paragraphs Sets** module (`paragraphs_sets`) — this module wraps its
  `data_alter` hook, so Paragraphs Sets must be present. Drupal enables it as a
  dependency when you turn on Paragraphs Sets Plugins.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/paragraphs_sets_plugins -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install and update the
required modules (including Paragraphs Sets) as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/paragraphs_sets_plugins -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en paragraphs_sets_plugins -y
```

There is no admin UI to configure — enabling the module makes its process plugins
(`simple`, `create_entity`, `nested_entities`) available to your Paragraphs Set
definitions, and registers the `@ParagraphsSetsProcess` plugin type so you can add
your own.

## Verify it worked

Reference one of the process plugins (for example `create_entity`) from a
Paragraphs Set definition, then apply that set while editing content. The set's
data should be transformed by the plugin — for instance, creating and
pre-populating the referenced entities — rather than left as static prefilled
values. See "How to use it" on the [overview page](../index.md) for an example.
