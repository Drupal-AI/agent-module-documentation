<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Static Generator — Drush & operation

Service: `static_generator` (`src/StaticGenerator.php`). Drush wrapper: `src/Commands/StaticGeneratorCommands.php`. All operations require operator/CLI access or the `administer static generator` permission on the web.

## Commands
| Command | Purpose |
|---|---|
| `drush sg` | Generate everything (pages, blocks, files, redirects). |
| `drush sgp [path] [--queued\|--q]` | Generate pages (optionally under a path, optionally via queue). |
| `drush sgpt <type> <bundle> [start] [length]` | Generate pages for an entity type/bundle range. |
| `drush sgb [--frequent \| block_id]` | Generate blocks (all, frequent-only, or one). |
| `drush sgf [--public \| --code]` | Generate public files and/or code files (rsync). |
| `drush sgr` | Generate redirects. |
| `drush sgd [--pages \| --esi \| all]` | Delete generated pages / ESI / all (confirm prompts). |

## Web routes (admin-only)
- `POST-less` generation triggers: `/node/{nid}/gen`, `/media/{mid}/gen` (regenerate one entity's page).
- Info: `/node/{node}/sg`, `/media/{media}/sg`.
- Config: `/admin/config/static_generator` and `/admin/config/static_generator/type/{entity_type_id}`.
- All gated by `administer static generator` (restrict access); there is **no web deletion route** — deletion is Drush-only.

## How generation works
- Pages render as the **anonymous** user; only **published** nodes are generated (unless `gen_unpublished`).
- Default `render_method: Guzzle` issues an HTTP request to `guzzle_host` (avoids a core block-caching bug); `guzzle_options` config is `eval()`-ed into a Guzzle options array.
- ESI: elements with a class starting `sg-esi--` become ESI includes so shared fragments regenerate independently.
- Moderation: `static_generator.module` queues generation when `moderation_state` becomes `published`, deletes on `archived`, scoped to configured `gen_node` bundles.

## Key config (`static_generator.settings`)
`generator_directory` (default `private://`), `rsync_public` / `rsync_public_exclude` / `rsync_code`, `paths_generate` (`/node`), `render_method` (`Guzzle`), `guzzle_host`, `guzzle_options`, `esi_blocks`, `esi_sg_esi`, `gen_unpublished`, `generate_index`.

## Security / operator notes
- Shell strings (`rsync`, `mkdir -p`, `rm -rf`) are built **unquoted** from admin config + `DRUPAL_ROOT` + generator-directory scans — no request input reaches them, but a malicious admin config value is command-injection (requires `administer static generator`).
- `guzzle_options` is `eval()`-ed (`StaticGenerator.php:1686`) and can disable TLS with `['verify' => false]` — admin-trust only.
