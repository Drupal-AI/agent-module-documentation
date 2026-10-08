# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core **Content Translation** (`content_translation`), **Language** (`language`),
  **Node** (`node`) and **Taxonomy** (`taxonomy`) modules. Drupal enables these as
  dependencies when you turn on Create and translate.

Note that **Taxonomy** is a dependency even though the feature itself is about the node
form — enabling this module will turn Taxonomy on if it isn't already. There are no
third-party PHP or JavaScript library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/create_and_translate -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/create_and_translate -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en create_and_translate -y
```

There is no configuration step on Drupal 8+ — the extra save-and-translate button
appears on the node form automatically.

## Verify it worked

Make sure your site has more than one language configured and that a content type is
enabled for translation. Then add a node of that type: alongside the normal **Save**
button you should see the module's save-and-translate button, and clicking it should
land you on the node's **Translate** overview rather than on the saved node.
