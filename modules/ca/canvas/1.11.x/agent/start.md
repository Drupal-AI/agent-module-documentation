<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drupal Canvas (canvas) — agent index

Visual, in-browser experience builder for Drupal 11. Content creators arrange reusable
components (SDCs, blocks, JS "code components") into a stored **component tree** and wire
prop values to Drupal data — no code required. Inverts Drupal's data-first model: layout
first, then data via shape-matched "prop sources". React SPA over an internal HTTP API,
with an auto-save draft/publish workflow.

Requires core: block, editor, ckeditor5, filter, text, datetime, file, image, link,
media_library, options, path. `core_version_requirement: ^11.3`, PHP 8.3. Composer lib:
`justinrainbow/json-schema:^6.8.0`.

**Important:** Canvas 1.x ships **no stable public PHP or HTTP API** — all classes and
endpoints are `@internal` and may change. Do not build integrations against its
controllers/services yet. (No `api` doc for that reason.)

- Config entities, admin routes, key UI paths, and settings → [configure/configure.md](configure/configure.md)
- Plugin types you can implement (component sources, extensions, adapters) → [plugins/plugins.md](plugins/plugins.md)
- Hooks the module invites (`canvas.api.php`) → [hooks/hooks.md](hooks/hooks.md)
- Permissions and what they gate → [permissions/permissions.md](permissions/permissions.md)

Concepts (from `docs/`): component tree, component instance, prop shape / shape matching,
static vs. entity-field prop sources, prop expressions, ComponentSource plugins.
No Drush commands. No hook_theme public API to rely on.

**1.11.x notes:** `PageRegion` is **deprecated in canvas:1.11.0** (removed in 2.0.0) in
favour of the new `page_variant` (PageVariant) config entity — the UI's "page templates".
Both share the `administer page template` permission. A new intrinsic `marker` ComponentSource
provides the page-content marker (`marker.page_content`) that designates where a page variant
injects the route's main content.

Ships 11 submodules (most `hidden`, dev/experimental): `canvas_ai` (AI, needs
drupal/ai + ai_agents), `canvas_dev_ai` (experimental client-side AI loop), `canvas_dev_cd`
(conflict detection), `canvas_dev_er` (deprecated entity-ref props), `canvas_dev_mode`
(extensions toolbar + private APIs), `canvas_dev_translation` (deprecated), `canvas_headless`
(decoupled frontend in editor via preview tokens; needs simple_oauth/consumers/custom_elements),
`canvas_oauth` (OAuth2 for the external API), `canvas_page_template_component` (exposes theme
page templates as components), `canvas_personalization`, `canvas_vite` (HMR).
