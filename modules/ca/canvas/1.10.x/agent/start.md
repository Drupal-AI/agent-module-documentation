# Drupal Canvas — agent index

Visual, in-browser experience builder for Drupal 11. Content creators arrange reusable
components (SDCs, blocks, JS "code components") into a stored **component tree** and wire
prop values to Drupal data — no code required. Inverts Drupal's data-first model: layout
first, then data via shape-matched "prop sources". React SPA over an internal HTTP API,
with an auto-save draft/publish workflow.

Requires core: block, editor, ckeditor5, filter, text, datetime, file, image, link,
media_library, options, path. `core_version_requirement: ^11.3`, PHP 8.3.

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

Ships 10 submodules (most `hidden`, dev/experimental): `canvas_ai` (AI, needs
drupal/ai + ai_agents), `canvas_dev_ai` (experimental client-side AI loop), `canvas_dev_cd`
(conflict detection), `canvas_dev_er` (deprecated entity-ref props), `canvas_dev_mode`
(extensions toolbar + private APIs), `canvas_dev_translation` (deprecated), `canvas_headless`
(decoupled frontend in editor via preview tokens; needs simple_oauth/consumers/custom_elements),
`canvas_oauth` (OAuth2 for the external API), `canvas_personalization`, `canvas_vite` (HMR).
