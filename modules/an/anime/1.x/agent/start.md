<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Anime (anime) — agent index

A thin integration that loads the **Anime.js** JavaScript animation library site-wide. Package
`User interface`. **No** routes, permissions, settings form, services, config or plugins — its
only job is to attach the library so your own JS can call `anime()`. Core requirement
`^8.8 || ^9 || ^10 || ^11`. License GPL-2.0-or-later. Version 1.0.3 (version-dir `1.x`).

- **How the library is loaded, the local-vs-CDN logic, and how to use it** →
  [libraries/loading.md](libraries/loading.md)

## What it actually is

- **Not** anime video content — it integrates the anime.js animation engine
  (`juliangarnier/anime`, https://animejs.com/), which animates CSS properties, SVG, DOM attributes
  and JS objects.
- Pure procedural module: `anime.module`, `anime.install`, `anime.libraries.yml`,
  `anime.info.yml`. No `src/`, no routing/permissions/services/config YAML.

## Mechanism (from source, `anime.module`)

- `anime_page_attachments(&$attachments)` (hook_page_attachments) runs on **every** page. If the
  `anime_ui` module is **not** enabled, it attaches library `anime/anime.js` when a local copy
  exists, otherwise `anime/anime.cdn`. Skips during installation.
- `anime_check_installed()` → `_anime_build_manual_file_path()` looks for the library via
  `anime_find_library()` (core `LibrariesDirectoryFileFinder`, searching site / root / profile
  `libraries/` dirs) under names `anime`, `animejs`, `anime.js`, expecting
  `.../lib/anime.min.js`.
- `anime_detect_version()` reads that file and regex-extracts the version (`anime.js vX.Y.Z`).
- `anime_help()` (hook_help) prints the module's own `README.md` inside `<pre>` on
  `help.page.anime`.
- `anime_requirements()` (hook_requirements) reports OK when local, ERROR (CDN in use) otherwise,
  linking the GitHub download.
- `anime_install()` warns if no local library is present.

## Libraries (`anime.libraries.yml`)

- `anime.js` → local `/libraries/anime/lib/anime.min.js` (declared version 3.2.2, MIT).
- `anime.cdn` → external `//cdnjs.cloudflare.com/ajax/libs/animejs/3.2.2/anime.min.js`.

See [libraries/loading.md](libraries/loading.md) for the full attach path, install steps and the
`anime_ui` interaction.
