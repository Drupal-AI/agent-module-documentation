<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Fluid UI - Infusion integrates the Fluid Project's **Infusion UI Options** framework into a Drupal site's front end, adding a "display preferences" toolbox that lets visitors adjust font size, line height, font family, contrast theme, link styling, and generate a table of contents — with their choices saved in a cookie and reapplied on every page.

---

The module bundles a precompiled copy of the Infusion library (v4.8.0) inside its own `infusion/` directory and loads it locally, so no external CDN or download step is required to get a working widget — optionally, a site can drop a custom-compiled Infusion build into `/libraries/infusion` and the module's `hook_library_info_alter` will use that copy instead. On each front-end page, `fluidui_preprocess_page()` attaches the `fluidui.infusion` and `fluidui.theme` asset libraries; `js/fluidui_load.js` then bootstraps the widget by calling `fluid.uiOptions()` against the `.flc-prefsEditor-separatedPanel` container rendered from `templates/fluid-ui-block.html.twig`. By default the toolbox is auto-rendered at the top of every non-admin page via `hook_page_top`, but a `fluidui_as_block` setting switches it to a placeable `fluidui_block` block so you can position it in any region. A small settings form at `/admin/config/fluidui/adminsettings` (config object `fluidui.adminsettings`) controls whether the toolbox also appears on admin pages, whether it runs as a block, and a newline-separated URL blacklist (with trailing `/*` wildcard support) of paths where it should be hidden. To avoid a flash of unstyled preferences, `fluidui_preprocess_html()` reads the visitor's `fluid-ui-settings` cookie server-side and adds matching `fl-theme-*` / `fl-font-*` body classes on first render. Interface translations are shipped as JSON files under `messages/{en,fr,es}` and copied to `public://fluidui-translations/` at install rather than being managed through Drupal's translation UI.

---

- Give visitors a preferences toolbox to change font size, contrast, and line spacing.
- Add a research-grounded accessibility layer to a public-facing site.
- Let users pick a high-contrast theme that persists across page loads.
- Offer a dyslexia-friendly font-family switch.
- Generate an on-demand table of contents from a page's headings.
- Support low-vision users who need larger text without browser zoom.
- Enhance form input styling for readability.
- Reapply a visitor's saved display preferences on every page automatically.
- Show the toolbox only on the public site and keep it off admin pages.
- Extend the toolbox onto admin pages when staff need it too.
- Hide the toolbox on specific paths (e.g. checkout or login) via the URL blacklist.
- Hide the toolbox on whole path prefixes using a trailing `/*` wildcard.
- Place the preferences widget in a chosen theme region as a block.
- Swap in a custom-compiled Infusion build from `/libraries/infusion`.
- Serve the accessibility library entirely from your own server (no CDN).
- Provide preference controls in English, French, or Spanish via bundled JSON messages.
- Meet a procurement requirement for user-adjustable presentation.
- Complement (not replace) accessible markup and design work.
- Underline or bold links for visitors who need stronger link cues.
- Avoid a flash of default styling by rendering saved preferences server-side.
