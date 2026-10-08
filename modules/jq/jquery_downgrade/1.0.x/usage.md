jQuery Downgrade selectively swaps Drupal 11's bundled jQuery 4 for jQuery 3 (loaded from a CDN) on specific nodes, Views pages, or entire themes — for code not yet compatible with jQuery 4.

---

The module targets Drupal 11+ (which ships jQuery 4) and lets you keep legacy jQuery-3-dependent JavaScript working without downgrading the whole site. Configuration lives in a single config object, `jquery_downgrade.settings`, edited at `/admin/config/development/jquery-downgrade` (route `jquery_downgrade.settings`, permission "administer site configuration"). You specify: `node_ids` (a list of node IDs), `view_routes` (Views page route names like `view.frontpage.page_1`), `enable_theme_downgrade` (a boolean), and `downgrade_themes` (a list of theme machine names). At runtime an OOP hook, `JQueryDowngradeHooks::alterAttachments()` (`hook_page_attachments_alter()`), checks the current route: if the current node is in `node_ids`, or the current route name is in `view_routes`, or theme-based downgrade is on and the active theme is in `downgrade_themes`, it removes the `core/jquery` library from the page attachments and instead attaches `jquery_downgrade/jquery_legacy` — a library that loads jQuery 3.6.4 from `code.jquery.com`. The module defines no permissions of its own, no Drush commands, and no plugin types; its only moving parts are the settings form, the config object, the OOP hook, and the `jquery_legacy` library definition.

---

- Keep a legacy contrib module that breaks under jQuery 4 working on the one page it is used.
- Serve jQuery 3 only on a specific node that embeds an old third-party jQuery plugin.
- Downgrade jQuery on a particular Views page whose Views-provided JS assumes jQuery 3.
- Force jQuery 3 site-wide for a specific (older) theme via theme-based downgrade.
- Gradually migrate to jQuery 4 by whitelisting only the pages already tested.
- Avoid patching core or a theme just to restore jQuery 3 behavior on a few routes.
- Load jQuery 3 for an admin/report page that uses an incompatible jQuery UI widget.
- Restrict the downgrade to a marketing landing node without affecting the rest of the site.
- Support a slideshow/carousel library that only works with jQuery 3 on selected nodes.
- Keep a custom dashboard functional during a jQuery 4 upgrade window.
- Enable jQuery 3 for a subtheme while the main theme moves to jQuery 4.
- Target a Views-based calendar page that depends on jQuery-3-era plugins.
- Provide a temporary compatibility shim while dependencies are updated.
- Downgrade jQuery on a contact or webform page that loads legacy validation scripts.
- Whitelist several node IDs at once by listing them one per line.
- Roll out jQuery 4 to editors' themes while keeping the public theme on jQuery 3.
- Test jQuery 4 on staging pages while production-critical pages stay on jQuery 3.
- Ensure a third-party embed that requires jQuery 3 renders correctly on its host node.
- Configure the downgrade entirely via exported config (`jquery_downgrade.settings`) for deployment.
- Remove the jQuery 3 override page-by-page as each is verified compatible with jQuery 4.
- Keep an old jQuery datepicker working on a booking node until it is replaced.
- Apply the legacy jQuery only where needed to minimize the extra external CDN request.
