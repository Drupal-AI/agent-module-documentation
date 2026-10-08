jQuery UI Button re-provides the single jQuery UI Button widget asset library as a standalone contrib module after jQuery UI was deprecated and removed from Drupal core. It has no configuration, no permissions and no services — you install it and attach the `jquery_ui_button/button` library where you need it. The button widget also covers the legacy `buttonset()` behavior, so there is no separate `buttonset` library.

---

Drupal core historically bundled the jQuery UI Button widget, but jQuery UI is no longer actively maintained (marked End of Life by the OpenJS Foundation), so core deprecated and removed it. This module ships just the Button piece so existing themes, modules and custom code that used `$.fn.button()` / `$.fn.buttonset()` keep working. It carries no PHP logic of its own — no `.module` file, no `.libraries.yml`. The library is declared on its behalf by the base `jquery_ui` module, whose `hook_library_info_alter()` reads `jquery_ui.libraries.data.json` and registers the `jquery_ui_button/button` library (the vendored jQuery UI 1.13.2 `button-min.js` plus the base `button.css` theme). That is why the module depends on `jquery_ui` (`>=8.x-1.7`, composer `^1.7`). Unlike most of the split-out widget modules, the Button widget also needs the Controlgroup and Checkboxradio widgets, so this module additionally depends on `jquery_ui_controlgroup` (`>=2.1`) and `jquery_ui_checkboxradio` (`>=2.1`); the registered library's declared dependencies pull those in automatically along with `jquery_ui/widget` and jQuery UI internal helper libraries. There is nothing to configure — install the module and attach the library via `#attached` or a `dependencies` entry in your own `*.libraries.yml`. As with the rest of the jQuery UI contrib family, the maintainers recommend migrating off jQuery UI to a maintained alternative rather than taking on new dependencies.

---

- Restore the jQuery UI Button widget after upgrading to a Drupal core version where jQuery UI was removed.
- Attach `jquery_ui_button/button` to a render array via `#attached`.
- Depend on `jquery_ui_button/button` from your own module's `*.libraries.yml`.
- Depend on the button widget from a custom theme's `*.libraries.yml`.
- Keep a legacy contrib module that calls `$.fn.button()` working without patching it.
- Keep old code that calls `$.fn.buttonset()` working (buttonset is part of the button widget).
- Style buttons, links and inputs as jQuery UI themed widgets in a legacy form.
- Serve the vendored jQuery UI 1.13.2 `button-min.js` to the front end.
- Serve the base-theme `button.css` component stylesheet with the widget.
- Pull in the required `jquery_ui/widget` factory automatically as a transitive dependency.
- Pull in the Controlgroup and Checkboxradio widgets the Button widget needs, automatically.
- Avoid core deprecation warnings by depending on `jquery_ui_button/*` instead of the old `core/jquery.ui.button` library.
- Split the Button widget out as its own composer dependency (`drupal/jquery_ui_button`) in a project.
- Pin the Button widget explicitly in a distribution or install profile.
- Ensure a consistent jQuery UI Button version across a multisite platform.
- Bridge a contributed module during migration away from jQuery UI to a modern library.
- Enable only the Button widget without adding the full set of jQuery UI widget modules.
- Provide the widget assets to an old custom Twig template that renders jQuery UI button markup.
- Attach the Button widget alongside other split-out widgets such as jquery_ui_checkboxradio or jquery_ui_controlgroup.
- Give a custom JS behavior access to the `button` widget without vendoring it yourself.
- Depend on the module (`jquery_ui:jquery_ui_button`) from a custom module's `*.info.yml`.
