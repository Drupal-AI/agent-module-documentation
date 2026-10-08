Provides the jQuery UI Controlgroup widget as a Drupal asset library so themes and modules can group related form buttons and inputs into a single visually-connected control.

---

Drupal core removed the bundled jQuery UI libraries, splitting each widget into its own contrib project; `jquery_ui_controlgroup` is the one that re-exposes the Controlgroup widget. It is a thin dependency-provider module: it declares a dependency on the base `jquery_ui` module (which ships the actual jQuery UI assets under its `assets/vendor/jquery.ui/` directory) and registers the `jquery_ui_controlgroup/controlgroup` asset library so other code can depend on it. There is no configuration UI, no permissions, no plugins, no services, and the module ships no PHP or `*.libraries.yml` of its own — the library definition is contributed by the base `jquery_ui` module on its behalf. You enable it purely so that a `#attached` library or a theme's `libraries`/`libraries-extend` declaration can reference the Controlgroup assets (`controlgroup-min.js` and `controlgroup.css`), then initialize `.controlgroup()` on markup in your own JavaScript. It exists chiefly to keep legacy code and contributed themes/modules that still rely on jQuery UI Controlgroup working on modern Drupal 9/10/11. Because jQuery UI is no longer actively developed upstream, it is intended as a compatibility bridge rather than a foundation for new work.

---

- Enable jQuery UI Controlgroup support on Drupal 9, 10, or 11 after core dropped bundled jQuery UI.
- Provide the controlgroup asset library for a custom module's render array via `#attached`.
- Satisfy a dependency for a contributed module or theme that still requires jQuery UI Controlgroup.
- Keep a legacy theme's grouped button/input controls functional after a core upgrade.
- Visually group a set of related buttons into a single segmented control.
- Combine a select, checkbox, and button into one connected input group.
- Build a toolbar of radio-button toggles that render as a joined control.
- Group form action buttons (Save / Preview / Cancel) into a unified control cluster.
- Style paired label + input elements as a single rounded control group.
- Attach the library from a custom block plugin's build array.
- Depend on it from a base theme's `.libraries.yml` for consistent controlgroup styling.
- Initialize `.controlgroup()` on a container to auto-style all its child form widgets.
- Provide horizontal or vertical grouped controls via the widget's `direction` option.
- Pair with jQuery UI Checkboxradio to render grouped, styled radio/checkbox sets.
- Migrate a Drupal 7 site that used core jQuery UI controlgroup to Drupal 10/11.
- Reuse the widget across multiple modules by depending on a single shared library.
- Keep a decoupled admin/theme dependency chain intact during incremental jQuery UI removal.
- Build compact filter bars where several toggles read as one control.
- Render segmented view-mode switchers (list / grid / map) as a joined button group.
- Provide a consistent grouped-control look for custom admin forms that still use jQuery UI.
