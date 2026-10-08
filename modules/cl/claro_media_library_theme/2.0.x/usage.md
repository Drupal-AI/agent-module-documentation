<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Add Claro Media Library to Theme injects Claro's media library templates, preprocessing and CSS into the active theme's registry, so the media library keeps its full Claro styling even when it is opened outside the admin theme.

---

This is a fix for one specific, irritating symptom. Drupal's media library is a modal, and its Twig templates and preprocessing live in **Claro**, the admin theme. Open it from a node form in the admin theme and it is fine. Open it from anything rendered in the **front-end theme** — an inline entity form, a Layout Builder off-canvas dialog, a front-end editing interface, a custom form on a public page — and Claro's theme hooks are missing from the active theme's registry, so the grid collapses into an unstyled list and the add form loses its layout. Despite the project name and its `package: Theme`, this is a **module** (`type: module`), not a theme, and it has no templates of its own. It implements `hook_theme_registry_alter()` to register Claro's media-library theme hooks against Claro's own template files (and force-override existing core hooks to use them), `hook_library_info_alter()` to attach a small compatibility CSS library to the `media_library` widget/view/ui libraries, and form/views hooks that manually invoke Claro's own alter and preprocess functions — trying the legacy procedural `claro.theme` functions first and otherwise calling Drupal 11.4's `ClaroHooks` / `ClaroFormHooks` OOP hook classes. Because it points at core Claro's files rather than copying them, core stays the single source and there is no forked template set to keep in step on updates. Version **2.0.0-beta1** on **`^11.4`** — an exceptionally tight core requirement that pins it to a single minor, so re-check compatibility at every core update; it depends on core `media_library` and is not covered by the security advisory policy. It does one thing, has no configuration and no permissions, and is a candidate for removal if a future core release moves the library's theming out of the admin theme. Worth confirming the symptom is actually present before installing, since it only appears where the library is opened outside the admin theme.

---

- Fix an unstyled media library that appears in a front-end theme.
- Restore the media library grid layout in a non-Claro active theme.
- Use the media library widget on a public-facing form.
- Open the media library from a Layout Builder off-canvas dialog.
- Support front-end / in-place editing that embeds media.
- Avoid copying Claro's media-library templates into your theme.
- Keep media library styling correct across core updates without maintaining forked templates.
- Fix a broken media library modal opened outside admin.
- Support an inline entity form that uses the media library.
- Fix media selection styling in an off-canvas dialog.
- Keep the media library usable when the admin theme is not Claro.
- Support a custom or contrib admin theme that lacks the media-library templates.
- Fix the media library add form (upload / oembed) losing its layout on a front-end route.
- Keep editorial media tooling visually consistent site-wide.
- Reduce theme maintenance burden tied to core Claro changes.
- Ensure the compact media-library widget hides its weight toggle correctly.
- Center media previews consistently when Claro is not the active theme.
- Fix media library spacing inside a jQuery UI dialog.
- Support a decoupled or member-facing editing experience with media.
- Provide Claro's media-library preprocessing to hooks that would otherwise render unstyled.
