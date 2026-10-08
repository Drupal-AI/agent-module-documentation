<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Admin Toolbar Background Color sets the background color of the classic Admin Toolbar bar from a single color-picker setting, commonly used as a per-environment visual indicator.

---

Admin Toolbar Background Color adds one settings form (route `admintoolbar_bgcolor.settings` at
`/admin/config/administration/at-bgcolor`, gated by the `administer site configuration` permission)
with a single HTML5 color input, `AtbgColorSettingsForm` (a `ConfigFormBase`). The chosen value is
saved to the `admintoolbar_bgcolor.settings` config object under the `admintoolbar_bgcolor` key
(string, schema in `config/schema/admintoolbar_bgcolor.schema.yml`). On every page,
`admintoolbar_bgcolor_preprocess_page()` reads that config; when a color is set it attaches the
`admintoolbar_bgcolor/admin_toolbar_color` library and passes the value through
`drupalSettings.admintoolbar_bgcolor.toolbarColor`. The library's `js/admin-toolbar-color.js`
(`Drupal.behaviors.adminToolbarColor`) then finds `#toolbar-bar` and sets its
`style.backgroundColor` to that value; the bundled `css/admin-toolbar-color.css` provides a black
default. The module declares a dependency on `color_field` in its info file, and a menu link and
`hook_install` message point administrators at the settings page. It is a small administration/UX
convenience — no content, entities, permissions of its own, or Drush commands — and the typical use
is color-coding environments (for example a red toolbar on production) so operators can tell at a
glance which site they are editing.

---

- Set a custom background color for the classic Admin Toolbar bar.
- Color-code environments (e.g. red = production, green = dev) to avoid editing the wrong site.
- Give operators an at-a-glance visual cue of which environment they are in.
- Pick the toolbar color from a simple color-picker settings form.
- Apply a distinct brand color to the admin toolbar for a client site.
- Distinguish a staging site from production visually in the toolbar.
- Reduce the risk of accidental production changes by making prod visually obvious.
- Change the toolbar color without writing CSS.
- Store the toolbar color as a single site-wide configuration value.
- Deploy the color per environment via config split / config override.
- Apply the color automatically on every page for toolbar users.
- Provide a lightweight personalization of the administrative UI.
- Keep the setting under Configuration > Administration for easy discovery.
- Restrict who can change the color to users with "administer site configuration".
- Reset the toolbar to the default styling by clearing the setting.
- Pair the toolbar color with other environment-indicator conventions.
- Make screenshots and screen-shares self-documenting about their environment.
- Signal a maintenance or freeze window with a temporary toolbar color.
- Help distributed teams avoid cross-environment mistakes during releases.
- Apply a consistent admin look across a multisite via shared config.
