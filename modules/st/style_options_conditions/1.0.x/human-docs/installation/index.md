# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Paragraphs** module (`paragraphs`).
- The **Style Options** module (`style_options`).

Both are hard dependencies. The optional Layout condition (see below) makes most
sense with **Layout Paragraphs**, but that module is only a soft dependency — the
condition fails open if it is absent.

## Install with Composer

From the project root:

```bash
composer require drupal/style_options_conditions -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Paragraphs and
Style Options and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/style_options_conditions -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en style_options_conditions -y
```

## Optional submodule — Layout condition

To evaluate conditions against **Layout Paragraphs** context, also enable the
bundled submodule:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Style Options Conditions: Layout** | `style_options_conditions_layout` | A condition plugin that decides an option's visibility from Layout Paragraphs context. Layout Paragraphs is a soft dependency — if it isn't installed, the condition simply passes. |

```bash
drush en style_options_conditions_layout -y
```

## Verify it worked

After enabling, add a condition to a style option in one of your paragraph types'
`*.style_options.yml` files and rebuild caches. In the paragraph editor, that
option should appear only when its condition is satisfied — for example, only when
the paragraph is placed in the layout context you targeted.
