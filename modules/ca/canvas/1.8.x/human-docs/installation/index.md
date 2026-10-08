# Installation

## Requirements

- **Drupal 11.3 or newer** (`core_version_requirement: ^11.3`) — Canvas does not run
  on Drupal 10.
- **PHP 8.3 or newer**.
- The **justinrainbow/json-schema** library (`^6.8.0`), which Composer pulls in
  automatically.
- A number of core modules, enabled automatically as dependencies: **Block**,
  **Editor**, **CKEditor 5**, **Filter**, **Text**, **Datetime**, **File**,
  **Image**, **Link**, **Media Library**, **Options**, and **Path**.
- For image support you also need core **Media** and **Media Library** enabled (see
  the module's README).

## Install with Composer

From the project root:

```bash
composer require drupal/canvas -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — here it also brings in `justinrainbow/json-schema`.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/canvas -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en canvas -y
```

Enabling Canvas installs its config entity types and some bundled configuration —
the `canvas_html_block` and `canvas_html_inline` CKEditor 5 text formats (for editing
HTML props), a couple of image styles, and the global asset library and brand kit
defaults.

## Submodules — enable only what you need

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Canvas AI** | `canvas_ai` | AI assistance for building and editing components and layouts (integrates the `ai` and `ai_agents` modules). |
| **Canvas OAuth** | `canvas_oauth` | OAuth2 authentication for Canvas's external HTTP API (built on Simple OAuth). |
| **Canvas Personalization** | `canvas_personalization` | Personalization / segmentation so component trees can vary by audience. |
| **Canvas Vite** | `canvas_vite` | Hot Module Replacement via a Vite dev server, for fast code-component development. |

For example, to add AI assistance:

```bash
drush en canvas_ai -y
```

Each submodule requires the base Canvas module, which is already present once you
have installed it above.

## Before you can build

Canvas is the builder, not the components. Before you can compose anything you need
a component system — build your own single-directory components or code components,
or start from an existing set (for example the Mercury theme, or scaffold code
components with `@drupal-canvas/create` / Nebula). Then head to
[Configuration](../configuration/index.md).
