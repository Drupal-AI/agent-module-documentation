# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- The **Canvas** module (`drupal/canvas`) — the Experience Builder page builder.
- Core **Content Translation** (`content_translation`) and **Language**
  (`language`) modules.
- This is an **experimental**, **beta** release (**1.0.0‑beta1**). Treat it as
  work in progress and verify the translation behaviours you depend on.

> **Local development note:** on standard development images (DDEV and similar,
> where `zend.assertions` is on) Canvas can fail to stay enabled because of a
> Single‑Directory Component assertion. This is a dev‑environment issue —
> production PHP compiles assertions out — but it can block a local install of
> Canvas. See the [overview](../index.md) for details.

## Install with Composer

From the project root:

```bash
composer require drupal/canvas_multilingual -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in and update shared
dependencies (including Canvas and the core translation modules if needed).

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/canvas_multilingual -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en canvas_multilingual -y
```

Enabling it pulls in Canvas, Content Translation, and Language as dependencies if
they are not already on. Configure your site languages and translatable entities
in the usual way, then edit and translate Canvas pages in the builder.
