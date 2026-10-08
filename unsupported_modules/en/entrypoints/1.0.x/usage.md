<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entrypoints bridges a JavaScript build toolchain and Drupal's library system: it reads entrypoint/manifest definitions produced by bundlers and exposes each build as a Drupal library that can be attached to render arrays, blocks or responses. It supports server-side rendering (SSR) of entrypoints, pluggable runtimes (npm, yarn), renderer plugins (e.g. a node renderer), and input handlers that feed data into a build.
It targets developer/DevOps workflows where front-end apps or components are compiled and need to be registered and served as Drupal libraries, optionally rebuilt from within Drupal.
---
Install with `composer require drupal/entrypoints` and enable it. Configuration lives at `/admin/config/entrypoints` (view/edit gated by `view entrypoints config` / `edit entrypoints config`) and a rebuild workflow at `/admin/config/entrypoints/rebuild` (gated by `rebuild entrypoints`). The `edit entrypoints config` and `rebuild entrypoints` permissions are declared `restrict access: true` because rebuilding compiles projects via a runtime (npm/yarn) — a powerful, trusted-admin operation.
The module provides an `EntrypointBlock`, an SSR response subscriber/processor, plugin managers for runtimes/renderers/input handlers, Drush commands (`drush.services.yml`), and a settings/rebuild form. Building/compiling is an administrative, permission-gated action, not a request-time endpoint, so the execution surface is limited to users holding the restricted rebuild permission.
---
- Install: `composer require drupal/entrypoints && drush en entrypoints -y`.
- Manage entrypoint definitions at `/admin/config/entrypoints` (perm `view`/`edit entrypoints config`).
- Rebuild/compile entrypoints at `/admin/config/entrypoints/rebuild` (perm `rebuild entrypoints`).
- Attach a built entrypoint as a Drupal library to a render array.
- Place an entrypoint via the provided block plugin.
- Use SSR support to server-render an entrypoint into the HTML response.
- Choose an npm or yarn runtime plugin for building.
- Add renderer plugins (e.g. node renderer) for custom output.
- Feed data into builds via input handler plugins.
- Run rebuilds from the CLI with the module's Drush commands.
- Keep `edit`/`rebuild` permissions restricted (declared restrict access: true).
- Only trusted admins should hold rebuild rights — it runs build tooling.
- Register compiled front-end apps/components as first-class libraries.
- Version/rebuild assets without hand-editing `*.libraries.yml`.
- Integrate a webpack/Vite manifest into Drupal's asset pipeline.
- Use plugin managers to extend runtimes/renderers/input handlers.
