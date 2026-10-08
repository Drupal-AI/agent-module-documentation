<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Canvas Jumbotron (canvas_jumbotron) — agent index

A **config-only** module that ships one ready-made **Jumbotron** (hero/banner) code component for the **Canvas / Experience Builder** page builder. Version 1.0.1. Core `^10 || ^11`. No PHP, routes, services, permissions, or Drush.

## What it provides
- A Canvas code component (React `js_component`) `jumbotron`, defined entirely in `config/install`:
  - `canvas.js_component.jumbotron` — the source component: React `js.original`/`js.compiled`, machine name `jumbotron`, slots **header / button / footer**, one prop **image** (`$ref: json-schema-definitions://canvas.module/image`).
  - `canvas.component.js.jumbotron` — the component instance (`id: js.jumbotron`, `source: js`, label "Jumbotron") wiring the image prop to a Media image entity reference via a Canvas field expression.
- Renders `<section>` containing an optional `<img>` plus three slot `<div>`s; if no image is chosen it renders the text-only variant (no `<img>`).

## Dependencies (functional; NOT declared in info.yml)
- Requires the **canvas** (Experience Builder) module — it owns the `canvas.js_component` / `canvas.component` config entity types and the `image` json-schema.
- Config install pulls in the Media stack: `file`, `media`, `media_library`, plus `media.type.image`, `field.field.media.image.field_media_image`, and image style `image.style.canvas_parametrized_width`.
- `canvas_jumbotron.info.yml` itself declares **no** `dependencies:` — enabling on a site without canvas/media will fail to import the config.

## No config schema of its own
Ships `config/install` entities but no `config/schema/*.yml`; schema is provided by the canvas module. `provides_config_schema: false`.

## Solution docs
- [agent/components/jumbotron.md](components/jumbotron.md) — the two config entities, slots/props, the React source, image binding, install/operate.
