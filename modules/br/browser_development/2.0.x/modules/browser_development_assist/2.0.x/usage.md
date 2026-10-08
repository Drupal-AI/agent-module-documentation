<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Browser Development Assist keeps the CSS file produced by Browser Development attached to the front-end theme so the main editor module can be removed on production while its styling still renders.

It has no UI. `hook_library_info_build()` builds a library `browser-development-assist` whose `css.theme` entry is the path returned by `FileSystemStructure::getCssFilePath()` (`/<site path>/files/browser-development/css/default.css`). `hook_page_attachments()` attaches that library only when the active theme equals the configured default theme. `hook_css_alter()` moves the file into CSS group 300 so it loads after other theme CSS. There are no routes, permissions, services, config or non-core dependencies.

Typical setup: enable `browser_development_assist` after Browser Development has compiled CSS at least once; it will then re-serve that CSS. This lets you uninstall `browser_development` on production and keep only the compiled stylesheet.

---

Short summary: a Browser Development companion that re-attaches the compiled CSS file to the default theme's front-end.

It solves the deployment concern of shipping Browser Development's generated CSS without shipping the editor itself: enable this submodule and uninstall the editor, and the compiled stylesheet keeps loading via a lightweight library attach. It targets only the default theme and raises the CSS group weight so the file loads late.

---

- Serve Browser Development's compiled CSS on production without the editor module.
- Attach the generated stylesheet automatically on front-end pages.
- Limit the attach to pages rendered with the site's default theme.
- Load the CSS late (group 300) so it overrides earlier theme styles.
- Reduce runtime surface/performance cost by uninstalling the editor while keeping its output.
- Point a Drupal library at the existing `files/browser-development/css/default.css` file.
- Keep front-end styling intact after removing `browser_development`.
- Use as the "production half" of a two-module dev/prod split.
- Deploy generated CSS as a normal aggregated Drupal asset.
- Operate with no configuration, routes or permissions to manage.
