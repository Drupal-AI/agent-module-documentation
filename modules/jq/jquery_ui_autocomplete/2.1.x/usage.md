jQuery UI Autocomplete provides the jQuery UI Autocomplete library as a Drupal asset library so themes and modules can keep using the autocomplete widget after it was removed from Drupal core. It is a thin library-provider module with no configuration of its own.

---

When Drupal core dropped its bundled jQuery UI libraries, each widget was moved into a standalone contrib module. This module ships the `jquery.ui.autocomplete` component and exposes it as the Drupal asset library `jquery_ui_autocomplete/autocomplete`. Modules or themes that still need the jQuery UI autocomplete text-field-with-suggestions widget can depend on that library instead of the removed core one. Because the autocomplete widget renders its suggestion list using the menu widget, this module depends on both the base `jquery_ui` module and `jquery_ui_menu`. It has no admin UI, settings, permissions or plugins — installing it simply makes the library attachable. Its purpose is backward compatibility for legacy custom and contrib code during the move away from jQuery UI. New development should prefer native HTML autocomplete or a modern JavaScript component.

---

- Restore the jQuery UI Autocomplete widget after upgrading to a Drupal version where it was removed from core.
- Attach the `jquery_ui_autocomplete/autocomplete` asset library from a custom module.
- Attach the library from a theme via a `*.libraries.yml` dependency.
- Satisfy a contrib module that still declares a dependency on the jQuery UI Autocomplete library.
- Add type-ahead suggestions to a custom text field on a form.
- Wire an autocomplete input to a remote JSON source using the jQuery UI API.
- Keep a legacy autocomplete widget working through a Drupal core upgrade.
- Provide suggestion dropdowns in a custom administrative screen.
- Reuse one shared autocomplete library instead of bundling copies per module.
- Ensure the required `jquery_ui_menu` and `jquery_ui` assets load first via declared dependencies.
- Build a tags/token input field backed by jQuery UI autocomplete.
- Offer client-side filtering of a fixed list of options as the user types.
- Provide the widget on Drupal 9.2, 10 and 11 from a single module.
- Target a stable Drupal library ID instead of a CDN script in custom JS.
- Support combobox-style select replacement in a legacy theme.
- Add autocomplete to a search box in a back-office tool.
- Isolate jQuery UI usage to the modules that require it while planning removal.
- Preserve exact legacy autocomplete behavior while scheduling a rewrite.
- Reference the library from a Layout Builder custom block's attachments.
- Ship the autocomplete component as a Composer-managed dependency of a distribution.
