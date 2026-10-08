<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Acquia CMS Component (acquia_cms_component) — agent index

Component-library glue module for Acquia CMS ("Acquia Drupal Starter Kit"). Ships **Single Directory
Components (SDC)** only — no PHP `src/`, no routes, no permissions, no `config/install`, no config schema.
Components live under `components/` and are discovered by the contrib `component` (SDC) module.

- **Version:** 1.3.12 · **Package:** Acquia CMS · **Core:** `^9.4 || ^10 || ^11` · **License:** GPL-2.0-or-later
- **Dependencies (Drupal):** `acquia_cms_common`, `component`, `jsonapi_extras`
- **External JS (loaded from unpkg CDN by the react_library component):** react@17, react-dom@17,
  create-react-class@15.7.0, babel-standalone@6.26.0

## What it provides

Three Single Directory Components (no plugin types, services, hooks, or Drupal libraries of its own):

1. **`react_component_block`** (`type: block`) — "React Node Component Block". A React widget that lists
   the most recent nodes of a chosen type over JSON:API. `form_configuration`: `type`
   (article/page/place/person) and `display_item` (5/10/20/30). Depends on the two library components.
2. **`react_library`** (`type: library`) — loads React 17 + react-dom + create-react-class +
   babel-standalone as external `//unpkg.com` scripts.
3. **`api_library`** (`type: library`) — registers `window.DrupalApi`, a small JS helper
   (`drupal-api.js`) for building/calling JSON:API requests (`baseUrl: /jsonapi/`).

## Solution docs

- [Components: React node block](components/react_component_block.md) — the block component, its config,
  and the client-side data flow.
- [Components: shared JS libraries](components/libraries.md) — `react_library` and `api_library` /
  `DrupalApi`.

## Operate

`composer require drupal/acquia_cms_component` then `drush en acquia_cms_component`. Place the "React Node
Component Block" via the SDC block UI (provided by `component`). No settings form (`configure: null`).
The site's JSON:API must be enabled (via `jsonapi_extras`) and `node/<type>` reads must be permitted for
the viewing user for the block to return data.
