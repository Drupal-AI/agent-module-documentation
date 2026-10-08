Bootstrap UI loads and configures the Bootstrap CSS/JS framework across a Drupal site from one admin settings form, with a choice of CDN, a locally installed library, or a Composer-installed library.

---

Bootstrap UI has no field, block, or template features of its own; it is a site-wide asset loader. From `admin/config/user-interface/bootstrap` an administrator picks how Bootstrap is delivered (jsDelivr/cdnjs CDN, the `/libraries/bootstrap` local directory, or a Composer-managed copy), which major/minor version to use, whether to serve minified (production) or unminified (development) files, and exactly which asset files load (full CSS vs. individual grid/reboot/utilities/theme/responsive parts; the bundled or standalone JS, or no JS at all). It can be restricted to specific themes and specific URL paths (allow-list or block-list), and it can serve the RTL build (or an included RTL patch for Bootstrap 3/4) automatically on right-to-left pages. Loading is implemented through `hook_page_attachments()` plus a `hook_library_info_alter()` that rewrites the module's library definitions to point at the chosen version and files. The module ships no entities, services, or plugins; other modules can register alternative UI kits (for example the MDBootstrap Material Design kit) via the `bootstrap_ui_library_name` hook so they appear in the same form. All settings live in a single `bootstrap_ui.settings` config object behind the `administer bootstrap ui` permission.

---

- Add the Bootstrap 5 CSS/JS framework to a custom theme without editing the theme's `*.libraries.yml`.
- Serve Bootstrap from the jsDelivr CDN with zero local files during early development.
- Switch from the CDN to a locally hosted `/libraries/bootstrap` copy for production and offline builds.
- Install Bootstrap through Composer as a separate package and load it with the module.
- Pin the exact Bootstrap release (for example 5.3.7, 5.1.3, or 4.6.2) used across the site.
- Use an older Bootstrap major version (2.x, 3.x, or 4.x) for a legacy theme via the "Other versions" selector.
- Auto-detect the installed local library's version by reading its file header (no manual version entry).
- Serve minified (production) assets on the live site and switch to unminified assets for debugging.
- Load only the Bootstrap grid CSS (skip the rest) for a lightweight layout-only integration.
- Load only the reboot/normalize CSS to reset styles without pulling in components.
- Load only the Bootstrap 5 utilities CSS for utility classes.
- Add Bootstrap CSS but no JavaScript at all when components are not needed, to save bandwidth.
- Load the standalone Bootstrap JS (without Popper) when dropdowns/tooltips/popovers are handled elsewhere.
- Load the bundled Bootstrap JS that includes Popper for full component support.
- Enable right-to-left (RTL) support so Persian, Farsi, or Arabic pages get the correct Bootstrap RTL stylesheet.
- Apply the module's bundled RTL patch for older Bootstrap 3.x/4.x versions that ship no native RTL build.
- Restrict Bootstrap loading to one or more selected themes (or every theme except the selected ones).
- Restrict Bootstrap loading to specific URL paths using wildcards (for example only the front page, or everything except `/admin/*`).
- Disable Bootstrap on a single page request on the fly by appending `?bootstrap=no` to the URL.
- Keep Bootstrap off admin, node-edit, IMCE, batch, and AJAX paths by default to avoid clashing with the admin theme.
- Suppress the "Bootstrap library is missing" status-report warning when intentionally staying on the CDN.
- Check the Bootstrap install status and detected version from the site Status report (Reports → Status report).
- Let a companion module (such as MDBootstrap) register its Material Design UI kit so it is selectable in the same form.
- Prevent double-loading by disabling the module's loader when a theme already ships Bootstrap itself.
