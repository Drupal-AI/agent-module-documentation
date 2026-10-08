<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Static Suite decouples Drupal into a static-site pipeline: export Drupal data to files, build a static site with an SSG (Gatsby, Hugo, Next.js, Astro), and deploy the resulting release to a CDN/host — all orchestrated from inside Drupal.

---

The suite is layered as submodules. **static_export** serializes entities, config, and locale to data files (JSON/XML/YAML) through pluggable data resolvers (GraphQL, JSON:API, JSON serializer), re-exporting automatically on CRUD events via a stream-wrapper-backed store (`static-local`, `static-git`). **static_build** runs the chosen static builder as a background shell process (via the `src/Cli/CliCommand` proc_open wrapper and `StaticBuilderPluginManager`), assembling the command from the builder plugin's annotation plus admin build options. **static_deploy** pushes the built release to a deployer (e.g. S3). **static_preview** (and `static_preview_gatsby_instant`) offers preview without a full rebuild. Cross-cutting services provide release management (`ReleaseManager` swaps a `current` symlink between timestamped release dirs), async task tracking surfaced in the toolbar, a `FilePathSanitizer`/`UriSanitizer` layer that strips path traversal from export URIs, and a `CliCommandFactory`. Admin settings and export/build/deploy configuration forms require `administer site configuration`.

The many `exec()`/`proc_open` calls are admin-only build/deploy tooling: their shell strings come from module config, plugin annotations, and validated internal release paths (with `../` and realpath guards) — no HTTP request input reaches them. The request-facing surfaces to keep in mind are the sanitizer- and permission-gated export file/URI viewers, the `authenticated`-role build/deploy "running-data" polling endpoints, and (if enabled) the `access content`-gated `static_preview_gatsby_instant` page resolvers that take a request-supplied `pagePath`. TLS is not disabled anywhere, and the one `unserialize()` is hardened with `allowed_classes`.
---
- Decouple Drupal into an export → build → deploy static pipeline.
- Export entities, config, and locale to JSON/XML/YAML data files.
- Auto-re-export data when content changes via CRUD event subscribers.
- Choose a data resolver (GraphQL, JSON:API, or JSON serializer).
- Build a static site with Gatsby, Hugo, Next.js, or Astro.
- Run an SSG build as a background process from Drupal.
- Trigger an on-demand build from the admin UI (`run builds on demand`).
- Deploy a built release to S3 or another deployer.
- Manage releases as timestamped directories with a `current` symlink.
- Publish a release by atomically swapping the symlink.
- Keep a configurable number of past releases for rollback.
- Preview changes without a full rebuild (static_preview).
- Add instant per-page Gatsby preview (`static_preview_gatsby_instant`).
- Monitor build/deploy progress in the admin toolbar.
- View static build/deploy/export logs under `/admin/reports/static/*`.
- Download a built release archive (`download release`).
- Export data to a Git-backed stream wrapper for versioned data.
- Run export/build/deploy from Drush commands.
- Resolve a page path or entity to its exported data URI via the URI resolver API.
- Sanitize export URIs to prevent path traversal (FilePathSanitizer).
- Restrict CLI-command execution to configured users (`cli_allowed_users`).
- Configure build trigger regexes so only relevant changes rebuild.
- Set the export work directory and log retention.
- Gate all settings forms behind `administer site configuration`.
- Copy exported data between environments with the export Drush commands.
