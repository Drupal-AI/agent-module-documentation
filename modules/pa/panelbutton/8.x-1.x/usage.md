<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Panel Button adds the CKEditor 4 "Panel Button" utility plugin, which provides the shared dropdown/floating-panel UI that other user-facing CKEditor button plugins (such as Color Button) build on.

---

This is a dependency-only integration: `src/Plugin/CKEditorPlugin/PanelButton.php` registers the upstream CKEditor 4 `panelbutton` add-on with Drupal's core CKEditor 4 editor. It exposes no toolbar buttons of its own — it is a "utility plugin" required by certain other CKEditor plugins that need a rich toggle panel (colour pickers, custom dropdowns). You download the CKEditor `panelbutton` library (v4.5.6+) into `/libraries`, enable this module, and enable the plugin that depends on it.

Because CKEditor 4 was removed from Drupal core in Drupal 10, this module is only relevant on sites still running the contrib CKEditor 4 editor. It has no configuration, routes, permissions, or request-handling code of its own.

---

- Provide the floating-panel UI other CKEditor plugins depend on
- Satisfy the dependency of CKEditor Color Button
- Enable rich dropdown panels in CKEditor 4 toolbars
- Load the upstream panelbutton library into Drupal
- Support custom CKEditor plugins that need a panel widget
- Keep panel UI code shared instead of duplicated per plugin
- Register the panelbutton plugin with Drupal's CKEditor 4
- Act as a required dependency for the Color Button module
- Enable colour-picker style panels in the editor toolbar
- Reuse the upstream CKEditor panelbutton add-on in Drupal
- Provide a toggleable panel container for other button plugins
- Underpin dropdown/palette widgets contributed by other modules
- Ship a thin plugin wrapper with no config of its own
- Serve sites still running the contrib CKEditor 4 editor
- Bundle the panel UI once for multiple dependent plugins
