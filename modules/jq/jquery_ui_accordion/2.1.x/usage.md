Provides the jQuery UI Accordion widget as a Drupal asset library so themes and modules can attach collapsible accordion panels.

---

Drupal core removed the bundled jQuery UI libraries, splitting each widget into its own contrib project; `jquery_ui_accordion` is the one that supplies the Accordion widget. It is a thin dependency-provider module: it declares a dependency on the base `jquery_ui` module (which ships the actual jQuery UI assets) and exposes the accordion library so other code can depend on it. There is no configuration UI, no permissions, no plugins, and no services — you enable it purely so that a `#attached` library or a theme's `libraries-extend`/`libraries` declaration can reference the jQuery UI accordion assets. Custom modules attach the library in a render array and then initialize `.accordion()` on markup in their own JavaScript. It exists chiefly to keep legacy code and contributed themes/modules that still rely on jQuery UI Accordion working on modern Drupal 9/10/11. Because jQuery UI is no longer actively developed upstream, it is intended as a compatibility bridge rather than a foundation for new work.

---

- Enable jQuery UI Accordion support on Drupal 9, 10, or 11 after core dropped bundled jQuery UI.
- Provide the accordion asset library for a custom module's render array via `#attached`.
- Satisfy a dependency for a contributed module that still requires jQuery UI Accordion.
- Keep a legacy theme's collapsible accordion sections functional after a core upgrade.
- Build FAQ pages with expand/collapse question panels.
- Create collapsible "read more" sections in node templates.
- Group long-form content into tabbed/stacked accordion panes.
- Add collapsible sidebar navigation blocks.
- Show product specification groups as accordion sections on a commerce site.
- Render multi-step form sections as collapsible panels.
- Provide accordion-style help or documentation panels in an admin screen.
- Attach the library from a custom block plugin's build array.
- Depend on it from a base theme's `.libraries.yml` for consistent accordion styling.
- Migrate a Drupal 7 site that used core jQuery UI accordion to Drupal 10/11.
- Initialize `.accordion()` on a menu tree to create a collapsible mega-menu.
- Wrap taxonomy term listings in collapsible category panels.
- Display FAQ or glossary entries grouped alphabetically in accordions.
- Provide progressive-disclosure UI for dense data tables.
- Keep a decoupled admin/theme dependency chain intact during incremental jQuery UI removal.
- Reuse the widget across multiple modules by depending on a single shared library.
