# Installation

## Requirements

Storybook depends on a couple of Composer libraries and, for actually viewing
components, an external Node application. It needs:

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The PHP **DOM** extension (`ext-dom`).
- Three Composer libraries, installed automatically when you require the module:
  - `symfony/dom-crawler` and `symfony/css-selector`
  - `e0ipso/twig-storybook` (`^1.5`) — the library that provides the `{% stories %}`
    and `{% story %}` Twig tags.
- **The external Storybook application** (Node/npm) — only needed to *browse*
  components, and set up separately (see [Configuration](../configuration/index.md)).

## Install with Composer

From the project root:

```bash
composer require drupal/storybook -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Symfony and
twig‑storybook libraries and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/storybook -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en storybook -y
```

Enabling the module registers the Twig tags, the Drush commands, and the render
route. There is no configuration form to visit — the setup that remains is a
permission, an optional development mode, CORS, and the external Storybook app, all
covered in [Configuration](../configuration/index.md).

## A note on production

Storybook is a development tool. Keep the **Render storybook stories** permission and
the `storybook.development` mode **off in production**, and only enable them in your
local or CI environments.
