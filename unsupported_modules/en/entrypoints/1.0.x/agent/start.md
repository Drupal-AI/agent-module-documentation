<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entrypoints (entrypoints) — agent index

**Exposes front-end asset builds (bundler entrypoint manifests) as Drupal libraries; pluggable npm/yarn runtimes, renderers, input handlers, SSR, block, Drush + rebuild form.**

- **Version:** 1.0.x  •  core: `^9 || ^10`  •  configure: `entrypoints.settings_form`.
- **Permissions:** `view entrypoints config`; `edit entrypoints config` and `rebuild entrypoints` are `restrict access: true`.
- **Routes:** `/admin/config/entrypoints` (view+edit+rebuild), `/admin/config/entrypoints/rebuild` (rebuild). Block `EntrypointBlock`; SSR subscriber/processor; plugin managers for Runtime/Renderer/InputHandler; Drush commands.

**Security (reviewed, sound):** build/compile runs a runtime (npm/yarn) but only through the admin rebuild form/CLI gated by the restricted `rebuild entrypoints` permission — not a request-time or anonymous endpoint. Config/rebuild permissions correctly marked restricted. No unauth execution path found.
