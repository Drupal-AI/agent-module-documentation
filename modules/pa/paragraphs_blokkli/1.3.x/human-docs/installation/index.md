# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- The [Paragraphs](https://www.drupal.org/project/paragraphs) module (`paragraphs`)
  enabled — this is the base dependency.

There are no third‑party PHP library requirements declared, but individual
submodules integrate with other systems (for example the GraphQL and Search API
submodules expect those modules to be present), so enable a submodule only when
its companion module is installed.

## Install with Composer

From the project root:

```bash
composer require drupal/paragraphs_blokkli -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/paragraphs_blokkli -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en paragraphs_blokkli -y
```

## Submodules — enable only what you need

Paragraphs Blokkli ships several optional submodules. Enable them individually with
`drush en` once the base module is installed, and only alongside the companion
module each one integrates with:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| Comment | `paragraphs_blokkli_comment` | In‑editor commenting on content while building it. |
| Conversion | `paragraphs_blokkli_conversion` | Converting/transforming existing content into the blökkli editing model. |
| Fragments | `paragraphs_blokkli_fragments` | Support for blökkli "fragments" (non‑paragraph editable pieces). |
| GraphQL | `paragraphs_blokkli_graphql` | A GraphQL layer for the editor — pair with the GraphQL module. |
| Library | `paragraphs_blokkli_library` | Reusable paragraph libraries within the visual editor. |
| Scheduler | `paragraphs_blokkli_scheduler` | Scheduling of visually edited content. |
| Search | `paragraphs_blokkli_search` | Search inside the editor. |
| Search API | `paragraphs_blokkli_search_api` | Search API integration — pair with Search API. |
| Transform | `paragraphs_blokkli_transform` | Content transform helpers. |

For example, to add reusable libraries:

```bash
drush en paragraphs_blokkli_library -y
```

## Verify it worked

Go to **People → Permissions** and confirm the Paragraphs Blokkli permissions now
appear — grant them to an editor role. Then open a piece of content that uses a
Paragraphs field as that editor: you should be able to build and rearrange
paragraphs visually with the blökkli editor rather than through the standard nested
forms.
