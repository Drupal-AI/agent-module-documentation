<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Vite — agent index

Rewrites opted-in Drupal asset libraries so their **source** paths (`src/app.ts`,
`src/style.scss`) are served from Vite's hashed `dist` build (via `manifest.json`) — or from a
running Vite dev server for HMR. Driven entirely by info.yml / libraries.yml / settings.php.
No admin UI, no permission, no config entity, no Drush, no plugins.

- **Enable Vite for a theme/module/library and every config key** (info.yml, libraries.yml,
  `$settings['vite']`, dev server) → [configure/enable.md](configure/enable.md)
- **Resolve a single built asset path in PHP** (`vite.vite` service: `getChunk`,
  `processLibraries`) and how the manifest is read → [api/service.md](api/service.md)
- **Resolve a built asset path in Twig** (`vite_get_chunk_path()`) →
  [theming/twig.md](theming/twig.md)

Key facts:
- Entry point: `hook_library_info_alter()` → `vite.vite`::`processLibraries()`.
- Default build output dir `dist`; default manifest `dist/.vite/manifest.json`
  (`Manifest` class; `getChunk()` maps a source path → built `file`, `getStyles()` → its CSS).
- Dev server auto-probe URL `http://localhost:5173/@vite/client`; when up, assets point at the
  dev server and `vite/vite-dev-client` (`@vite/client`) is added. Ground truth for tests is the
  **manifest / library config**, not a live server.
