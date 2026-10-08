<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Library Manager gives Drupal's asset library system an administrative interface: define new libraries, override existing ones, and author the JavaScript and CSS in a CodeMirror editor that then gets attached like any other library.

---

Libraries are normally declared in a `*.libraries.yml` file and altered with `hook_library_info_alter()`, which is correct and also means a code deployment for every change. This module exposes the same machinery through `library_definition` config entities: add JS and CSS files by inline code, by managed-file upload, by local path or by external URL; set `preprocess`, `minified`, `header`, `type="module"`, `nomodule` and weight per file; declare dependencies, version and licence; and override any library that any extension declares, through the module's own `hook_library_info_alter()`. Which pages a definition attaches to is controlled by the same condition plugins that power block visibility. There is also a build form (seed a definition from an existing library), a YAML export, a duplicate operation, an admin listing at `/admin/structure/library`, and an assets-check report at `/admin/reports/libraries` (plus `drush lm:*` commands) that walk every registered library and confirm each asset URL loads.

That is genuinely useful for a small class of jobs — adding a third-party widget's snippet, patching the load order of a stubborn library, injecting a tracking or accessibility script, marking a script as `type="module"`, or prototyping a front-end change without a release. It also has an obvious cost: front-end code stops living in version control. Anything added here is site *configuration*, so it exports and deploys with config, but it will not show up in a code review of the theme and it will not be found by a developer grepping the repository. Everything the module does is gated behind the `administer libraries` permission (`restrict access: true`) except the read-only assets report (`access site reports`); treat it as the powerful, trusted-administrator tool it is and use it for genuine site configuration, not as a substitute for the theme.

---

- Define a new asset library without editing a `.libraries.yml`.
- Override a library declared by core, a module or a theme.
- Fix the load order of a stubborn third-party library.
- Add a small JS snippet for a third-party widget.
- Author CSS in the browser with syntax highlighting (CodeMirror).
- Upload a JS or CSS file and attach it as a library.
- Reference an external library by CDN URL.
- Mark a script as `type="module"` or `nomodule`.
- Load a script in the header rather than the footer.
- Control preprocessing and minification per file.
- Set a library's version and licence metadata.
- Declare dependencies between libraries.
- Restrict a library to specific pages using visibility conditions.
- Override an existing library only on certain pages (override-by-visibility).
- Duplicate an existing library definition as a starting point.
- Seed a definition from an existing library with the build form.
- Export a library definition as YAML (UI or `drush lm:export`).
- List every registered library from the CLI (`drush lm:list`).
- Review which libraries a site defines at `/admin/structure/library`.
- Verify every library asset still loads at `/admin/reports/libraries` (or `drush lm:check-assets`).
- Prototype a front-end change without a deployment.
- Ship a library definition through configuration deployment.
- Audit administrator-authored front-end code on an inherited site.
