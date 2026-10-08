<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Web Patches report page

The page at **`/admin/reports/webpatches`** (route `webpatches.list`, menu link under
`system.admin_reports`) lists the Composer patches declared for the site and the ones that are
declared but filtered out. It is read-only: patches are applied by Composer, this page only reads
the declarations. Requires permission **`view webpatches report`** (`restrict access: TRUE` — it
exposes server file paths and installed package versions, so restrict it to administrators).

Built by `Controller\PatchesController::listPatches()`, which pulls everything from the
`webpatches.collector` service (`PatchesCollector`). The render array sets `#cache max-age = 0`
because declarations live on disk, outside Drupal's cache invalidation.

![Web Patches report top](../../../../../../../screenshots/webpatches/12.0.x/report-top.png)

## Sections (in order)

1. **Intro** — a static note that Composer, not this module, applies patches.
2. **Patching sources** (`details`, collapsed) — `buildSourcesTable()`. One row per declaration
   *file* source with its resolved path and status (Disabled / Read / Not found). The
   `dependency_packages` source is skipped here because it is a lock file, not a declaration file;
   it gets its own sub-table, **Packages declaring patches** (`buildProvidersTable()`), listing each
   installed package that declares `extra.patches`, its version, patch count, and an **Allowed** /
   **Not allowed** verdict with the reason.
3. **Patch lock** — `buildLockSection()` from `getLockStatus()`. Shows one of: `patches.lock.json`
   not found (warning), in sync (status), or out of sync (warning) — the last with two `details`
   tables, **Declared but not in the lock** and **In the lock but no longer declared**.
4. **Patches** (`details`, open) — `buildPatchesTable()`. Every applied patch: package, patch cell,
   and the source it was declared in.
5. **Ignored patches** (`details`, open) — `buildIgnoredTable()`. Every declared-but-not-applied
   patch with the reason and the declaring provider.
6. **Filter note** — shown when `only_installed_packages` is on, linking to the settings form.

If `PatchesCollector::getProjectRoot()` returns NULL (no `composer.json` found within 4 parent
directories of `%app.root%`), the controller renders only a warning and returns early.

![Patches and lock-diff tables](../../../../../../../screenshots/webpatches/12.0.x/report-patches.png)

## How PatchesCollector discovers patches

`PatchesCollector` (service `webpatches.collector`, `implements PatchesCollectorInterface`) reads
only files on disk under the resolved project root; it never fetches a URL. Key methods:

- `getProjectRoot()` — walks up from `%app.root%` (max 4 levels) to the first dir containing
  `composer.json`. Cached; NULL when not found.
- `getSources()` — returns the four fixed sources keyed by the interface constants
  `SOURCE_ROOT` (`root_composer`), `SOURCE_PATCHES_FILE` (`patches_composer`),
  `SOURCE_CUSTOM` (`custom_file`), `SOURCE_DEPENDENCIES` (`dependency_packages`), each with
  `label`, resolved `path`, `enabled` (from config) and `found` (`is_file`).
- `collect()` (protected, memoized) — the core gather. For each **enabled** source it flattens the
  Composer `patches` declaration via `addDeclaredPatches()` / `normalizePatchList()`:
  - Root `composer.json` → `extra.patches`.
  - Patches file → path from `extra.composer-patches.patches-file` (v2, default `patches.json`) or
    top-level `extra.patches-file` (v1); falls back to first existing of `patches.json`,
    `patches.composer.json`. Reads its `patches` key.
  - Custom file → `custom_file_path` from settings; accepts a bare `{"patches": {…}}` file or a
    `composer.json`-shaped file (`extra.patches`).
  - Dependency packages → `addDependencyPatches()` (below).
  - `normalizePatchList()` accepts both Composer Patches formats: a `"description": "url"` map, and
    a v2 list of `{description, url}` objects. Entries without a string `url` are skipped.
  - Each patch is marked `installed` by cross-referencing `getInstalledPackages()`. When
    `only_installed_packages` is on, the returned list is filtered to installed packages (but
    `collectedAll`, used for the lock diff, keeps the full set).
- `addDependencyPatches()` / `getPatchProviders()` — iterate `composer.lock` packages
  (`packages` + `packages-dev`; fallback `vendor/composer/installed.json` when no lock). For each
  package with `extra.patches`, apply the same filter the webship/patches plugin uses:
  - allowlist = `extra.composer-patches.allowed-dependency-patches`, default
    `['webship/patches','webship/drupal-patches']` (`DEFAULT_ALLOWED_DEPENDENCY_PATCHES`);
  - ignore list = `extra.composer-patches.ignore-dependency-patches`;
  - per-URL drops = `extra.patches-ignore`.
  - Matching uses `matchesAny()`, an fnmatch-equivalent regex (`*`, `?`) so a platform without
    `fnmatch()` still works.
  - Not-in-allowlist or ignored providers go to the **Ignored** list; individually ignored URLs go
    there too. The module's own package `drupal/webpatches` (`OWN_PACKAGE`) is always skipped so its
    leftover `extra.patches` metadata is never reported.
- `getLockStatus()` — compares the full declared set against `patches.lock.json` (`patches` map)
  keyed by `package|url`, returning `missing` (declared not locked) and `stale` (locked not
  declared) and an `in_sync` flag.

![Patching sources and providers](../../../../../../../screenshots/webpatches/12.0.x/report-sources.png)

## PatchLinks — how cells become links

`PatchLinks` (static) derives links defensively; every input comes from a `composer.json` on disk,
so each method returns NULL rather than guessing:

- `packageUrl($package)` — validates against Composer's package-name regex (`PACKAGE_PATTERN`);
  `drupal/*` → `https://www.drupal.org/project/<project>` (core → project `drupal`), anything else →
  Packagist. A name that fails the pattern is rendered as `#plain_text`, never linked.
- `issueId()` / the controller's `buildDescription()` — a `#<6-8 digits>` reference in the
  description is split out and linked to `https://www.drupal.org/node/<id>`; the surrounding text is
  emitted as `#plain_text` so a description is never rendered as markup.
- `mergeRequestId()` / `mergeRequestUrl()` — a `--mr-<id>` suffix in the patch file name plus a
  resolvable `drupal/*` project yields a `git.drupalcode.org/.../merge_requests/<id>` link.
- The controller's `buildPatchLink()` links the patch file only when it is a well-formed `http(s)`
  URL (`preg_match ^https?://` + `UrlHelper::isValid(..., TRUE)`); a local path is shown as plain
  text. All external links get `target=_blank rel="noopener noreferrer"`. The module does not fetch
  any of these URLs — they are display links only.
