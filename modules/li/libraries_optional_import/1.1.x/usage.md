<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Allows a theme to flag individual library assets as `optional: true` so they are silently removed when the file does not exist.

---

Drupal normally errors/warns when a declared library CSS or JS file is missing. This module hooks library info alteration and, for assets that carry an `optional` flag, checks whether the file actually exists under the owning theme's path (via `ThemeExtensionList` + `realpath`) and unsets any that are absent before the library is used. This is handy when a build pipeline conditionally produces some assets, or a subtheme may or may not ship a particular file.

Operation is purely declarative in the theme's `*.libraries.yml`: mark the asset `optional: true`. The module (service `Drupal\libraries_optional_import\OptionalImport`) does the filtering for both `js` and `css` groups. No configuration UI, routes, permissions, or user-facing surface — it only rewrites the in-memory library definitions at build time.

---

- Mark a CSS asset in a theme library as `optional: true` so a missing file is dropped.
- Mark a JS asset in a theme library as `optional: true` so a missing file is dropped.
- Avoid "missing library file" errors when a build conditionally emits some assets.
- Ship a subtheme that may or may not include a particular CSS/JS file.
- Let a theme reference assets produced by an optional build step without hard failures.
- Filter optional assets by real file existence under the owning theme's path.
- Apply the behavior to both `css` and `js` groups of a library.
- Keep required (non-optional) assets untouched and still enforced.
- Enable the module and rely on it with zero configuration.
- Use the `OptionalImport` service in custom code to prune optional assets.
- Combine with `hook_library_info_alter` workflows for conditional asset loading.
- Support environment-specific assets that only exist in some deployments.
- Prevent broken aggregation caused by a declared-but-absent optional file.
- Gate optional design/experiment assets behind their presence on disk.
- Load a fallback stylesheet only when a theme override file is not present.