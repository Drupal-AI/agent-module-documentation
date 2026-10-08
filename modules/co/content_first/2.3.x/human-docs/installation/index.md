# Installation

## Requirements

- **Drupal 10.6+ or 11** (`core_version_requirement: ^10.6 || ^11`).
- Core's **Node** module (`node`).
- Contrib **[Entity Render Context](https://www.drupal.org/project/entity_render_context)**
  (`^1.0`) and **Entity Registry** (`^1.0`) — Composer pulls these in.
- The PHP libraries **`league/html-to-markdown`** (`^5.1`) and
  **`symfony/css-selector`** (`^6.4 || ^7.0`), used to convert HTML to Markdown and
  strip selectors — installed automatically by Composer.
- Optional: the **[Metatag](https://www.drupal.org/project/metatag)** module, if
  you want metatag values to become Markdown front matter.

## Install with Composer

From the project root:

```bash
composer require drupal/content_first -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — important here, since Content First brings several
contrib and library dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/content_first -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en content_first -y
```

Drush pulls in the required dependencies (`node`, `entity_render_context`, and so
on) automatically.

## Optional: the audit submodule

Content First ships one submodule, **Content First Audit**
(`content_first_audit`), which adds automated heading and metatag auditing via
Entity Registry. Enable it only if you want that:

```bash
drush en content_first_audit -y
```

## Next steps

Set which entities/bundles get the tab and what appears as front matter at
**Configuration → Content authoring → Content First**, and grant the **View
content_first content** permission to the relevant roles — see the
[Configuration](../configuration/index.md) guide.
