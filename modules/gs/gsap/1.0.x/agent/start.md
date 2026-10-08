<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# GSAP (gsap) — agent index

Integrates the GreenSock Animation Platform (GSAP) JS library into Drupal. Defines
GSAP core plus every plugin as Drupal asset libraries a theme/module can depend on, and
lets site builders author animations as `gsap` **config entities** (no PHP/JS). Core
`^9.2 || ^10 || ^11`, no module dependencies. Settings form at `/admin/config/content/gsap`
(route `gsap.settings`); animation entities at `/admin/structure/gsap`. Provides one
permission, config schema, and no drush/plugins.

- **Attach GSAP + plugin libraries from a theme/module** → [theme/libraries.md](theme/libraries.md)
- **Global settings: load GSAP everywhere, pick plugins, add custom libraries** → [configure/settings.md](configure/settings.md)
- **Author animations as `gsap` config entities (selector + to/from + ScrollTrigger)** → [configure/animations.md](configure/animations.md)
- **Permission** → [permissions/permissions.md](permissions/permissions.md)
- **Hooks it implements (page attachments, dynamic custom libraries)** → [hooks/hooks.md](hooks/hooks.md)

Key facts:
- Asset libraries (`gsap.libraries.yml`): `gsap` (core) plus 22 plugin libraries —
  `flip`, `scrolltrigger`, `observer`, `scrollto`, `draggable`, `easel`, `motionpath`,
  `pixi`, `text`, `drawsvg`, `gsdevtools`, `inertia`, `motionpathhelper`, `morphsvg`,
  `physics2d`, `physicsprops`, `scrambletext`, `splittext`, `easepack`, `customease`,
  `custombounce`, `customwiggle` — plus a local `animations` library (`js/animations.js`).
  Depend on them as `gsap/<name>`, e.g. `- gsap/scrolltrigger`.
- Each library's JS is served from `https://cdn.jsdelivr.net/npm/gsap@3.13.0/dist/*.min.js`
  (`preprocess: false`). A shipped `composer.libraries.json` installs `greensock/gsap 3.13.0`
  locally; to serve locally you override the definitions (`hook_library_info_alter` /
  `libraries-override`).
- Config object `gsap.settings`: `include_gsap` (bool), `include_libs` (bool),
  `libs` (sequence of plugin machine names), `custom_libs` (sequence of `{key: path}`).
- Config entity `gsap` (config prefix `gsap.gsap.*`, `config_export`: id, label, description,
  event, scrolltrigger, selector, direction, json). Handlers in `src/Entity/Gsap.php`.
- Permission: `administer gsap` (gates the settings form and all entity CRUD routes).
- Hooks in `gsap.module`: `hook_page_attachments`, `hook_library_info_build`, `hook_help`.
