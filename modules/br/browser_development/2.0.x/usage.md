<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Browser Development gives a developer an in-browser code editor to author SCSS (and a JS-library reference), live-compile it to CSS, and both attach it to the current theme and persist it as portable configuration — front-end iteration without a local build toolchain.

It ships a home landing page, a React/ACE editor page, a settings form, and a POST `api` endpoint. The API decodes a posted JSON command and dispatches to `LiveScssCompiler` (`live` → compressed CSS for the live preview), `ScssCompiler` + `Processing\Storage` (`compiled` → writes `.scss` files under `public://browser-development/scss/`, compiles them via the scssphp/scssphp library, writes the CSS to `sites/*/files/browser-development/css/`, and serialises the SCSS payload into a `browser_development_storage` config entity), or `Storage::getStorage` (`open` → returns the most recently saved snippet). The optional `browser_development_assist` submodule re-attaches the generated CSS file so the editor module can be uninstalled on production while the stylesheet keeps loading. This is a development/QA convenience, not a production feature.

Typical setup (dev only): `composer require drupal/browser_development`, enable it, sign in as the superuser, open `/admin/browser-development`, author SCSS in the editor, and compile/save it into the active theme.

---

Short summary: an in-browser SCSS editor that live-compiles to CSS, applies it to the current theme, and stores the SCSS as portable Drupal configuration.

It solves the need to iterate on theme CSS from the browser — live SCSS compile, save compiled CSS to disk, and version-control the source as config entities — useful in prototyping and QA environments. A companion submodule (`browser_development_assist`) keeps the compiled CSS attached to the front-end theme after the editor itself is removed, so the styling ships to production without the editor's surface. Note that as shipped every route is gated by `_permission: 'TRUE'`, a permission no role can hold, so only the superuser can reach the editor and API; treat this strictly as a local development module.

---

- Write SCSS for the current theme from the browser in a development environment.
- Live-compile SCSS to compressed CSS while editing (the `live` API command).
- Compile a full set of SCSS files and save the resulting CSS to disk (the `compiled` command).
- Persist the authored SCSS as a `browser_development_storage` config entity for version control.
- Reopen the most recently saved snippet via the editor's `open` command.
- Reference a JS library path to load alongside the editor via the settings form.
- Prototype front-end changes without a local Sass/build toolchain.
- Iterate quickly on styles during QA or design review.
- Author component-style SCSS that is portable across multiple projects.
- Pair with `layout_builder_styles` so editors can attach generated classes to blocks/sections.
- Uninstall the editor on production but keep the compiled CSS via `browser_development_assist`.
- Manage the list of stored development snippets at `/admin/browser-development/storage`.
- Add, edit or delete stored snippets through the config-entity forms.
- Inspect editor asset paths and settings on the settings page.
- Use the module with any theme; the compiled CSS is a static file you can later fold into a custom theme.
- Keep experimental CSS scoped to a throwaway developer aid on non-production sites.
- Note: as shipped, all routes fail closed (`_permission: 'TRUE'`) — only the superuser (uid 1) reaches them without a code change.
