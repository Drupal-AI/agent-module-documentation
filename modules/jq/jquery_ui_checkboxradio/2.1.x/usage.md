jQuery UI Checkboxradio re-provides the single jQuery UI Checkboxradio widget asset library as a standalone contrib module after jQuery UI was deprecated and removed from Drupal core. It has no configuration, no permissions and no services — you install it and attach the `jquery_ui_checkboxradio/checkboxradio` library where you need it.

---

Drupal core historically bundled the jQuery UI Checkboxradio widget, but jQuery UI is no longer actively maintained (marked End of Life by the OpenJS Foundation), so core deprecated and removed it. This module ships just the Checkboxradio piece so existing themes, modules and custom code that used `$.fn.checkboxradio()` keep working. It carries no PHP logic of its own — no `.module` file, no `.libraries.yml`. The library is declared on its behalf by the base `jquery_ui` module, whose `hook_library_info_alter()` reads `jquery_ui.libraries.data.json` and registers the `jquery_ui_checkboxradio/checkboxradio` library (the vendored jQuery UI 1.13.2 `checkboxradio-min.js` plus the base `checkboxradio.css` theme). That is why the module depends on `jquery_ui` (`>=8.x-1.7`, composer `^1.7`): the base module supplies the vendored assets and the library-registration machinery. The Checkboxradio widget also depends on `jquery_ui/widget` and jQuery UI internal helper libraries, which are pulled in automatically through the library's declared dependencies. There is nothing to configure — install the module and attach the library via `#attached` or a `dependencies` entry in your own `*.libraries.yml`. As with the rest of the jQuery UI contrib family, the maintainers recommend migrating off jQuery UI to a maintained alternative rather than taking on new dependencies.

---

- Restore the jQuery UI Checkboxradio widget after upgrading to a Drupal core version where jQuery UI was removed.
- Attach `jquery_ui_checkboxradio/checkboxradio` to a render array via `#attached`.
- Depend on `jquery_ui_checkboxradio/checkboxradio` from your own module's `*.libraries.yml`.
- Depend on the widget from a custom theme's `*.libraries.yml`.
- Keep a legacy contrib module that calls `$.fn.checkboxradio()` working without patching it.
- Style checkboxes and radio buttons as jQuery UI themed widgets in a legacy form.
- Serve the vendored jQuery UI 1.13.2 `checkboxradio-min.js` to the front end.
- Serve the base-theme `checkboxradio.css` component stylesheet with the widget.
- Pull in the required `jquery_ui/widget` factory automatically as a transitive dependency.
- Provide the jQuery UI internal form-reset, labels and widget-css helpers the widget needs.
- Avoid core deprecation warnings by depending on `jquery_ui_checkboxradio/*` instead of the old `core/jquery.ui.*` library.
- Split the Checkboxradio widget out as its own composer dependency (`drupal/jquery_ui_checkboxradio`) in a project.
- Pin the Checkboxradio widget explicitly in a distribution or install profile.
- Ensure a consistent jQuery UI Checkboxradio version across a multisite platform.
- Bridge a contributed module during migration away from jQuery UI to a modern library.
- Enable only the Checkboxradio widget without adding the full set of jQuery UI widget modules.
- Provide the widget assets to an old custom Twig template that renders jQuery UI markup.
- Attach the Checkboxradio widget alongside other split-out widgets such as jquery_ui_button or jquery_ui_controlgroup.
- Give a custom JS behavior access to the `checkboxradio` widget without vendoring it yourself.
- Depend on the module (`jquery_ui:jquery_ui_checkboxradio`) from a custom module's `*.info.yml`.
