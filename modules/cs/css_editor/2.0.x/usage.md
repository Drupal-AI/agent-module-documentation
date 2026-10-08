<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
CSS Editor adds a **Custom CSS** box to every theme's settings page, with CodeMirror syntax highlighting and a live-preview iframe, and injects the saved CSS after all other stylesheets for that theme.

---

The module has no route and no `configure` key of its own: it works entirely by altering core's `system_theme_settings` form, so the editor appears at `/admin/appearance/settings/<theme>` for each theme. Saving stores four values per theme in the config object `css_editor.theme.<theme>` — `enabled`, `css`, `plaintext_enabled`, `autopreview_enabled` — plus a fifth key, `path`, which the module writes itself. A pre-submit handler calls the `css_editor.css_generator` service (`Drupal\css_editor\CssEditorService`), which writes the CSS to `public://css_editor/<theme>.css`, records that URI back into `css_editor.theme.<theme>:path`, and then triggers `drupal_flush_all_caches()`. Delivery is via two hooks: `css_editor_library_info_alter()` appends the generated file to the *active theme's* own `css_editor` library entry with weight `9999` (so it wins the cascade), and `css_editor_page_attachments()` attaches `<theme>/css_editor` whenever `_css_editor_get_stylesheet()` finds an enabled config with an existing file. `hook_cache_flush()` calls `regenerateAllCssFiles()`, so every theme's CSS file is rebuilt on each cache clear — meaning the file is disposable and the config is the source of truth. The editing UX comes from the `css_editor/codemirror` library (CodeMirror 5.31.0 loaded from cdnjs, so it needs outbound network access) and `css_editor/css_editor` (the module's own JS/CSS); a "plain text editor" checkbox turns CodeMirror off and an "auto preview" checkbox live-updates the preview iframe. That preview iframe loads the front page with `?theme=<theme>`, and the `theme.negotiator.css_editor` service (priority 100) switches the active theme for that request — but only when the HTTP referer is exactly `/admin/appearance/settings/<theme>`, so the query argument cannot be used to force a theme from elsewhere.

---

- Add a few site-specific CSS overrides without creating a subtheme.
- Let a site owner tweak colours or spacing from the browser after launch.
- Patch a third-party module's stylesheet issue quickly on production.
- Apply per-theme CSS: different rules for the front-end theme and the admin theme.
- Hide an element that a contrib module renders but you cannot configure away.
- Prototype design tweaks live in the preview iframe before committing them to a theme.
- Ship the custom CSS between environments as config (`css_editor.theme.<theme>`).
- Keep custom CSS out of the theme repo when the theme is a vendored/contrib theme.
- Give a client a safe place to add tracking-pixel or print styles.
- Add print-only rules (`@media print`) to an existing theme.
- Override CSS custom properties (`:root { --color-primary: … }`) of a modern theme.
- Add temporary "under maintenance"/banner styling and remove it later by toggling `enabled`.
- Fix a responsive breakpoint bug without a theme deployment.
- Style a Webform or Views output that has no theme hook of its own.
- Provide accessibility fixes (focus outlines, contrast) as a config-controlled overlay.
- Test a CSS change with the live preview before it affects real visitors.
- Turn CodeMirror off (`plaintext_enabled`) on locked-down sites with no CDN access.
- Turn off auto preview (`autopreview_enabled`) on slow connections.
- Regenerate all theme CSS files after a deployment with `css_editor.css_generator::regenerateAllCssFiles()`.
- Deploy the CSS through config import and let the next cache flush rebuild the file.
- Inspect which themes have custom CSS by listing `css_editor.theme.*` config objects.
- Keep the CSS as the last stylesheet on the page thanks to the weight `9999` library entry.
- Roll back a bad CSS change by reverting one config object instead of a theme release.
