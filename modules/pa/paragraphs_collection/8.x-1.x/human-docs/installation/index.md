# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- The [Paragraphs](https://www.drupal.org/project/paragraphs) module (`paragraphs`).
- Core's **Image** (`image`) and **Link** (`link`) modules — both are dependencies
  and Drupal will enable them for you.

There are no third‑party Composer or PHP library requirements.

> **Status note:** the documented version is `8.x-1.0-alpha12`, an **alpha** that
> describes itself as "a collection of EXPERIMENTS," and it is **not covered by
> Drupal's security advisory policy**. Treat it accordingly — pin the version you
> test, and be ready to manage change between releases.

## Install with Composer

From the project root:

```bash
composer require drupal/paragraphs_collection -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. Because this is an alpha, you may need to allow the
matching stability in your project's `composer.json` (for example an
`"minimum-stability": "alpha"` setting or a version constraint such as
`drupal/paragraphs_collection:^1@alpha`).

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/paragraphs_collection -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en paragraphs_collection -y
```

Enabling the module also installs its example paragraph types so the bundled
plugins have types to work with.

## Submodules

Two optional submodules ship with the project, mainly for evaluation and
development rather than production use:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| Demo | `paragraphs_collection_demo` | Demonstration content and paragraph types showing the plugins in action. |
| Test | `paragraphs_collection_test` | Test fixtures used by the project's automated tests. |

Enable the demo only if you want the examples:

```bash
drush en paragraphs_collection_demo -y
```

## Verify it worked

Visit the report pages **`/admin/reports/paragraphs_collection/layouts`** and
**`/admin/reports/paragraphs_collection/styles`** (as a user with *administer
paragraphs types*) — they should list the layouts and styles the module provides.
Then edit a paragraph type at **Structure → Paragraph types** and confirm the new
behaviour/style plugins appear in its **Behaviors** section.
