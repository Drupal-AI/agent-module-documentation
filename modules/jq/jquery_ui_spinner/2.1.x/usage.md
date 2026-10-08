<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
jQuery UI Spinner is a thin metapackage module that makes the deprecated-from-core jQuery UI Spinner widget available again as an attachable Drupal asset library (`jquery_ui_spinner/spinner`) for themes and modules that still need it.

---

jQuery UI's individual widgets were removed from Drupal core, so contrib re-publishes them as small standalone modules. This module carries no code of its own — only an `info.yml` and `composer.json` — and depends on `jquery_ui` and `jquery_ui_button`. The actual library definition (JS `assets/vendor/jquery.ui/ui/widgets/spinner-min.js`, CSS `themes/base/spinner.css`, version 1.13.2) lives in the `jquery_ui` module's `jquery_ui.libraries.data.json` and is injected into this module's namespace by `jquery_ui_library_info_alter()`, so after enabling you attach it as `jquery_ui_spinner/spinner`. Its declared dependencies pull in `core/jquery`, `jquery_ui_button/button`, `jquery_ui/widget` and several internal jQuery UI helpers. There is no configuration UI (`configure` is null), no permissions, no schema, and no services or plugins. You use it purely by attaching the library from a render array, a `#attached` property, or a `*.libraries.yml` dependency, then calling `.spinner()` in your own JavaScript. Like all of the jQuery UI ecosystem, upstream jQuery UI is itself end-of-life, so treat this as a compatibility bridge for legacy code rather than a foundation for new work.

---

- Re-enable the jQuery UI Spinner widget on a Drupal 10/11 site after it was removed from core.
- Attach `jquery_ui_spinner/spinner` to a custom module's render array via `#attached['library']`.
- Add the library as a dependency of a custom library in your `mymodule.libraries.yml`.
- Provide a numeric stepper (up/down arrows) on a number input in a custom form.
- Support a legacy theme or module that still calls `$(el).spinner()`.
- Give users increment/decrement buttons for quantity fields in custom UI.
- Build a currency or decimal spinner using jQuery UI's `numberFormat`/`step` options in custom JS.
- Keep an older contrib module working that declared a dependency on the core-era spinner library.
- Attach the spinner only on specific pages/forms rather than site-wide.
- Pair the spinner with `jquery_ui_button` styling, which it already depends on.
- Migrate a Drupal 7/8 feature that used `core/jquery.ui.spinner` to modern Drupal.
- Add min/max-bounded numeric inputs with keyboard and mouse-wheel stepping in custom JS.
- Use the spinner inside a jQuery UI dialog or other jQuery UI widget composition.
- Bridge a decoupled admin widget that expects the jQuery UI spinner API.
- Bundle the spinner CSS (`themes/base/spinner.css`) for consistent jQuery UI base theming.
- Depend on it from another jQuery UI subcomponent module you maintain.
- Load the minified spinner asset (weight -11) ahead of your initialization script.
- Provide accessible spinner controls where a plain HTML5 `number` input is insufficient for older browsers.
- Keep a third-party JS integration that assumes `jQuery.ui.spinner` is registered.
