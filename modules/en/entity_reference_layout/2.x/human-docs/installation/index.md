# Installation

## Requirements

Entity Reference with Layout builds on Paragraphs and core's layout system. It
needs:

- **Drupal 9.1, 10, or 11** (`core_version_requirement: ^9.1 || ^10 || ^11`).
- **Paragraphs** (`drupal/paragraphs` `^1.6`) — the field references paragraph
  entities.
- **jQuery UI Dialog** (`drupal/jquery_ui_dialog` `^2.0`) — used by the widget's
  section dialogs.
- Core's **Layout Discovery** (`layout_discovery`) module, which provides the
  actual layouts and is enabled as a dependency.

Because this is an experimental **dev** release, your project's
`minimum-stability` may need to allow `dev` (or you can require the exact dev
version) for Composer to resolve it.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_reference_layout -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Paragraphs and
jQuery UI Dialog and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/entity_reference_layout -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_reference_layout -y
```

Drupal enables Paragraphs, jQuery UI Dialog, and Layout Discovery along with it.

## Submodules — enable only what you need

ERL ships two optional helper submodules:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **ERL Layouts** | `erl_layouts` | A set of ready-made column layouts you can assign to sections, including "select from a list" / "force" modes that constrain what CSS classes authors may apply. |
| **ERL Paragraphs** | `erl_paragraphs` | A pre-built "Section" paragraph type, so you don't have to create one by hand. |

Enable them individually, for example:

```bash
drush en erl_paragraphs -y
```

Once the module is enabled, continue to [Configuration](../configuration/index.md)
to add the field to a content type.
