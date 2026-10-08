<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Libraries Provider lets a module or theme declare *how* its external front-end libraries are served, instead of hard-coding a CDN URL or a local path. The declaring extension adds a `libraries_provider` key to its `*.libraries.yml` entry; the site can then switch that library between the jsDelivr CDN and the local `/libraries` folder, pick a version, choose when to serve the minified file, select a variant, or let one library replace another. The optional `libraries_provider_ui` submodule adds an admin screen for all of this.

---

The mechanism is a `hook_library_info_alter` subscriber (`LibrariesReplacements`, wired through `core_event_dispatcher`'s `LibraryInfoAlterEvent`): for every discovered library that carries a `libraries_provider` key, it merges in defaults, overlays any saved `library` config entity, and rebuilds the `css`/`js` asset paths through a chosen **LibrarySource plugin**. Two source plugins ship: `cdn.jsdelivr.net` (builds `https://cdn.jsdelivr.net/npm/<npm_name>@<version>/<path>` and fetches available versions from the jsDelivr data API via `upstreamable/jsdelivr-api-client`) and `local` (serves from `/libraries/<asset-packagist-name>` and reads the version from the library's `package.json`). Each plugin exposes `getCanonicalPath()` / `getPath()` so a path can be normalised from one source and re-emitted for another, plus `isAvailable()` / `getAvailableVersions()`. Minification is resolved per component against `system.performance` (`always`, `never`, or `when_aggregating`). Overrides are stored as a `library` **config entity** (`libraries_provider.library.<extension>__<name>`; note the double underscore) whose `postSave`/`preDelete` clear the library-discovery cache and, when `custom_options` are set, compile SASS variables into the library's CSS file using the `sassphp` PHP extension. The base module has **no UI and no permission**; the `libraries_provider_ui` submodule provides the `/admin/structure/libraries` entity list/edit/revert forms gated by the `administer libraries` permission, and depends additionally on `form_options_attributes`. A `LibrarySource` plugin type (annotation `@LibrarySource`, namespace `Plugin/LibrarySource`) lets other modules add further sources (e.g. the `lp_fontawesome` contrib module). Two tokens are exposed: `[library:variant]` and `[library:version]`.

---

- A theme (e.g. Drulma) ships a CSS framework and wants site builders to choose CDN vs. local delivery of Bulma without editing YAML.
- Serve a JS/CSS library from jsDelivr on production but from `/libraries` on an air-gapped or CDN-forbidden environment, toggled per site.
- Meet a Content-Security-Policy or GDPR/privacy requirement that forbids third-party asset hosts by switching every managed library to `local`.
- Pin a specific upstream version of a library from the versions the jsDelivr API reports, chosen from a dropdown.
- Blacklist a broken or vulnerable upstream release so it never appears in the version selector (`blacklist_releases`).
- Force minified assets always (or never) regardless of Drupal's CSS/JS aggregation setting, or default to "when aggregating".
- Let a Bulmaswatch/Bootswatch-style skin library **replace** the base framework library so the base CSS is not loaded twice (`replaces`).
- Disable an optional library entirely (`enabled: false`) so its assets are voided even when attached.
- Offer named **variants** of a library (e.g. theme skins) selectable from the UI, with a per-variant docs URL surfaced in the form.
- Download a library via asset-packagist (`composer require npm-asset/...`) and have the UI automatically offer the local copy.
- Override upstream SASS variables (custom options) and recompile the library's CSS locally, without maintaining a full front-end build (requires `sassphp` and a locally-served library).
- Provide a module (like `lp_fontawesome`) that bundles a library definition plus a matching source plugin for a specific CDN.
- Add a new CDN or delivery mechanism by implementing a `LibrarySource` plugin.
- Centrally see, in one admin table, every managed library with its current version, source and enabled state.
- Revert a library override back to the extension's declared defaults (delete the config entity) from the UI.
- Track which library version/variant is in use inside other configuration via the `[library:version]` / `[library:variant]` tokens.
- Give site builders control over front-end library delivery while keeping the choice out of code, so it survives config export/import.
- Provide a consistent way for multiple contrib modules/themes to expose their libraries for CDN-or-local switching under one screen.
