# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- **Slick** (`drupal/slick`, `~2.0 || ~3.0`) — a required dependency, which in
  turn brings in **Blazy**. Composer installs both automatically.
- To manage carousel optionsets through the UI you'll want Slick's **Slick UI**
  submodule enabled (it provides the screens at `/admin/config/media/slick`).

Optional companions the module suggests:

- **Entity Reference Revisions** (`drupal/entity_reference_revisions`) — render
  Paragraphs and other revision-referenced entities as carousel slides.
- **Dynamic Entity Reference** (`drupal/dynamic_entity_reference`) — enables the
  sibling `slick_dynamicentityreference_vanilla` formatter for
  `dynamic_entity_reference` fields.

## Install with Composer

From the project root:

```bash
composer require drupal/slick_entityreference -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install Slick and Blazy
and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/slick_entityreference -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en slick_entityreference -y
```

Enable the Slick UI submodule too if you want to create or edit optionsets in the
admin UI:

```bash
drush en slick_ui -y
```

## Verify it worked

Go to the **Manage display** page of a bundle that has a **multi-value**
entity-reference field (for example
`/admin/structure/types/manage/article/display`). In that field's **Format**
dropdown you should see **"Slick Entity Reference Vanilla"**. If it's missing,
confirm the field's cardinality is greater than 1 — the formatter is hidden on
single-value fields. See [How to use it](../index.md#how-to-use-it) for the rest.
