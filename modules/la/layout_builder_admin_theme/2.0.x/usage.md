Layout Builder Admin Theme forces Layout Builder editing screens to render in the site's admin theme instead of the front-end theme, so laying out pages isn't broken by a custom front-end theme.

---

The module registers a theme negotiator (`LBATAdminNegotiator`, tagged `theme_negotiator` at priority `501`) that switches the active theme to the site's configured **admin theme** (`system.theme:admin`) whenever the current route is a Layout Builder editing form. It recognises those routes by inspecting the route's `_entity_form`/`_form` default: it applies on core's `RevertOverridesForm` and `DiscardLayoutChangesForm`, and on any form whose id ends with `.layout_builder` (the main Layout Builder editing UI). A single boolean setting, `lbat_enable_admin_theme` in config object `layout_builder_admin_theme.config` (default `true`), gates the whole thing — when it is `false` the negotiator's `applies()` returns early and Layout Builder keeps using the front-end theme. The setting is toggled from a one-checkbox config form at `/admin/config/content/lbat` (route `layout_builder_admin_theme.lbat_config_form`, permission `administer site configuration`), or directly via config. The module depends only on core's Layout Builder, defines no permissions of its own, ships no Drush commands and no plugins, and its only persistent state is that one config value. Because it reads `system.theme:admin` at request time, changing the site's admin theme changes which theme Layout Builder editing uses.

---

- Edit Layout Builder layouts in the clean admin theme (e.g. Claro) instead of a heavy custom front-end theme.
- Stop a front-end theme's CSS/JS from breaking the Layout Builder editing UI.
- Give content editors a consistent back-office look while arranging blocks and sections.
- Make the "Revert to defaults" (RevertOverridesForm) Layout Builder screen use the admin theme.
- Make the "Discard changes" (DiscardLayoutChangesForm) Layout Builder screen use the admin theme.
- Apply the admin theme to per-entity Layout Builder override editing and to default layout editing alike.
- Toggle the behaviour on or off site-wide from a single checkbox at `/admin/config/content/lbat`.
- Turn the admin-theme override off temporarily to preview layout editing in the real front-end theme.
- Control the setting from configuration management (`layout_builder_admin_theme.config: lbat_enable_admin_theme`).
- Switch which theme Layout Builder uses simply by changing the site's admin theme (`system.theme:admin`).
- Keep Layout Builder usable when the front-end theme lacks admin-oriented styling.
- Reduce editor confusion by matching Layout Builder to the rest of the administrative UI.
- Deploy the on/off state as config across environments (dev/stage/prod).
- Avoid writing a custom theme negotiator just to force the admin theme on layout screens.
- Provide a better editing experience on decoupled/headless sites whose front-end theme is minimal.
- Pair with Layout Builder Restrictions and other LB add-ons without any extra theming work.
- Ensure Layout Builder previews render with predictable admin styling for QA.
- Standardise the layout-editing look across a multisite by enabling one small module.
- Let a non-technical site owner fix "Layout Builder looks broken" by ticking one box.
- Roll back an accidental layout change on the admin-themed revert/discard forms.
