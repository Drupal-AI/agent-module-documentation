<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Static Suite — pipeline & operation

Static Suite is a layered set of submodules. Enable them bottom-up: `static_export` → `static_build` → `static_deploy` (+ `static_preview`).

## Layers
- **static_export** — serializes entities/config/locale to data files (JSON/XML/YAML). Pluggable **data resolvers**: GraphQL, JSON:API (`endpoint: /jsonapi`), JSON serializer. CRUD event subscribers re-export on change. Stream wrappers `static-local` and `static-git` (`git_binary: /usr/bin/git`). Settings: `work_dir`, `use_index`, `uri.scheme` (public), `exportable_entity/config/locale.*`.
- **static_build** — runs an SSG via `StaticBuilderPluginManager` + `Cli/CliCommand` (`proc_open`). Builder plugins: astro, gatsby, hugo, nextjs, aws_lambda, codebuild. Command = plugin annotation (`engine`+`command`) + admin options. Settings: `live/preview.builders`, `build_trigger_regexp_list`, `base_dir` (`/sites/default/static/build`), `number_of_releases_to_keep` (5), `semaphore_timeout`, `env` (`CI=true`).
- **static_deploy** — deployers (`static_deployer_s3`) push a release to a host/CDN. Settings mirror static_build.
- **static_preview / static_preview_gatsby_instant** — preview without full rebuild; gatsby-instant exposes `/api/static/preview/gatsby/instant/page-*-resolver/{pagePath}`.

## Releases
`ReleaseManager`/`ReleaseFactory`/`Release` model releases as timestamped dirs with a `current` symlink; `publish()` swaps the symlink atomically. Old releases pruned to `number_of_releases_to_keep`.

## Key routes & access
- Settings + export/build/deploy config forms: `administer site configuration`.
- `/admin/reports/static/*` logs: `access site reports` + specific `view static * files/logs` perms.
- `run builds on demand` / `run deployments on demand`; `download release`.
- Running-data polling (`/admin/static/.../running-data*`): `_role: authenticated`.
- `static_export.file_viewer` `/static/export/files/{uri_target}`: `view static export files` (input sanitized by FilePathSanitizer).
- URI resolver API `/api/static/export/uri-resolver/*`: `access uri resolver api`.
- gatsby-instant resolvers: `_permission: access content` (effectively anonymous on many sites) — takes request `pagePath`.

## Security notes for operators
- `exec`/`proc_open` build strings are **not** `escapeshellarg`-escaped; they rely on inputs being admin-config / plugin-annotation / validated release paths. No request input reaches them, but treat build config as trusted.
- Restrict CLI execution with `static_suite.settings: cli_allowed_users`.
- `FilePathSanitizer` (`src/Security/`) strips `..`/`%2e`/duplicate slashes from export URIs — the main untrusted-input-meets-filesystem guard.
