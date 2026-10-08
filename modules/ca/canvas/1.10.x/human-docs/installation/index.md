# Installation

## Requirements

- **Drupal 11.3** (`core_version_requirement: ^11.3`).
- **PHP 8.3.**
- The **`justinrainbow/json-schema`** PHP library (`^6.8.0`), installed
  automatically with Composer.
- A range of core modules that Canvas depends on and enables automatically:
  **block, editor, ckeditor5, filter, text, datetime, file, image, link,
  media_library, options, path**.
- Core **Media** and **Media Library** for image support.
- A **component system** to build with — you must supply your own SDCs / code
  components, or start from an existing set (for example the Mercury theme, or code
  components scaffolded with `@drupal-canvas/create` / Nebula). Canvas provides the
  builder, not the components themselves.

## Install with Composer

From the project root:

```bash
composer require drupal/canvas -W
```

This also installs the `justinrainbow/json-schema` library. The `-W`
(`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/canvas -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en canvas -y
```

Canvas provides **no Drush commands** of its own.

## Submodules — enable only what you need

Most Canvas submodules are hidden and/or experimental or developer-only. Enable
only the ones you specifically need, and keep the `canvas_dev_*` ones **off in
production**.

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Canvas AI** | `canvas_ai` | AI features to assist building/editing components and layouts. Needs `drupal/ai` and `ai_agents`. (Hidden.) |
| **Canvas OAuth** | `canvas_oauth` | OAuth2-based authentication for Canvas's external HTTP API (built on Simple OAuth). |
| **Canvas Headless** | `canvas_headless` | Embeds a decoupled frontend app in the editor with draft-mode preview via user-bound preview tokens. Needs `simple_oauth`, `consumers`, `custom_elements`. (Hidden.) |
| **Canvas Personalization** | `canvas_personalization` | Lets component trees vary by audience/segment. (Hidden.) |
| **Canvas Vite** | `canvas_vite` | Hot Module Replacement via a Vite dev server, for code-component development. (Hidden.) |
| **Canvas Dev Mode** | `canvas_dev_mode` | Puts Canvas into dev mode — shows the extensions toolbar and exposes private/internal APIs. Dev only. |
| **Canvas Dev CD** | `canvas_dev_cd` | Feature flag enabling conflict detection/resolution while it stabilizes. Dev only. |
| **Canvas Dev AI** | `canvas_dev_ai` | Experimental client-side AI orchestration loop; replaces the AI chat backend/UI while installed. Not for production. Depends on `canvas_ai`. |
| **Canvas Dev ER / Dev Translation** | `canvas_dev_er`, `canvas_dev_translation` | Deprecated, hidden feature-flag submodules. |

For example, to add OAuth for the external API:

```bash
drush en canvas_oauth -y
```

## Verify it worked

Log in as an administrator and go to **Appearance → Components**
(`/admin/appearance/component`) — you should see the Components collection. Then
visit **Content → Pages** (`/admin/content/pages`) and try **Add page** to boot the
Canvas editor. If you haven't installed a component system yet, the canvas will
have nothing to place — that's expected; supply components first (see
[Configuration](../configuration/index.md)).
