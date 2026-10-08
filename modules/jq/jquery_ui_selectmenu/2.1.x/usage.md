jQuery UI Selectmenu re-provides the jQuery UI Selectmenu widget as an asset library so themes and modules can keep using styleable custom select dropdowns after jQuery UI was deprecated and removed from Drupal core.

---

Drupal core historically bundled the jQuery UI Selectmenu widget as part of `core/jquery.ui`, but jQuery UI is no longer maintained and was deprecated and removed from core, so any code that relied on the widget would break. This small companion module restores exactly that one widget. It ships no PHP, no `*.module`, no `*.libraries.yml` and no configuration of its own; the actual library definition lives in the base `jquery_ui` module, which declares a `selectmenu` library on behalf of this module through its `hook_library_info_alter()` implementation. The resulting library id you attach is `jquery_ui_selectmenu/selectmenu`. Because the Selectmenu widget builds its menu using the jQuery UI Menu widget, this module depends on both `jquery_ui` (`>=8.x-1.7`) and `jquery_ui_menu` (`>=2.1`) so the menu assets and the alter hook are always present. There is no settings page, no permissions and no services — you install it, attach `jquery_ui_selectmenu/selectmenu`, and initialize `.selectmenu()` on a `<select>` element in your own JavaScript. The maintainers recommend migrating custom-styled selects off jQuery UI to a maintained alternative rather than adding new dependencies on it; this module exists to keep legacy code working during that transition.

---

- Restore the jQuery UI Selectmenu widget after upgrading to a Drupal core version where jQuery UI was removed.
- Attach `jquery_ui_selectmenu/selectmenu` to a render array so a page can build styled select dropdowns.
- Replace an old `core/jquery.ui` selectmenu dependency with the `jquery_ui_selectmenu/selectmenu` library.
- Keep a legacy custom module that calls `.selectmenu()` working without patching it.
- Serve the jQuery UI Selectmenu base CSS theme to style custom dropdowns.
- Load the minified jQuery UI Selectmenu widget JavaScript on demand.
- Declare a dependency on `jquery_ui_selectmenu/selectmenu` from your own module's `*.libraries.yml`.
- Provide a keyboard-accessible, themeable replacement for native `<select>` elements in a custom form.
- Supply the Selectmenu widget to a contrib module that split it out of core.
- Ensure the `jquery_ui_menu/menu` dependency is present as a transitive dependency of selectmenu.
- Avoid deprecation warnings by depending on `jquery_ui_selectmenu/selectmenu` instead of core jQuery UI.
- Pin the jQuery UI Selectmenu widget as an explicit, contrib-maintained dependency in a distribution.
- Keep a legacy field widget or formatter that renders jQuery UI selectmenus functioning.
- Bridge a themed dropdown component during migration away from jQuery UI to a modern select library.
- Attach selectmenu assets conditionally only on the routes/pages that actually render dropdowns.
- Guarantee a consistent vendored jQuery UI Selectmenu version across a multisite platform.
- Enhance server-rendered `<select>` markup with a custom `Drupal.behaviors` JavaScript behavior.
- Let a theme depend on `jquery_ui_selectmenu/selectmenu` so its styled dropdowns render correctly.
- Reintroduce custom exposed-filter or settings dropdowns that previously used core jQuery UI.
