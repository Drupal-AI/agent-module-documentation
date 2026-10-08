jQuery UI Menu provides the jQuery UI Menu library as a Drupal asset library so themes and modules can keep using it after it was removed from Drupal core. It is a thin library-provider module with no configuration of its own.

---

Drupal core deprecated and removed the bundled jQuery UI libraries, splitting each widget into its own contrib module. This module ships the `jquery.ui.menu` component (the JavaScript, CSS and its dependencies) and exposes it as the Drupal asset library `jquery_ui_menu/menu`. Any module or theme that still relies on the jQuery UI Menu widget can declare a dependency on that library instead of the removed core one. It depends on the base `jquery_ui` module (which vends the jQuery UI core/widget files) and is itself a dependency of `jquery_ui_autocomplete`. There is no admin UI, no settings, no permissions and no plugins — installing it simply makes the library attachable. It exists mainly to preserve backward compatibility for older custom code and contrib modules during the transition away from jQuery UI. New development is encouraged to use native browser features or modern JavaScript instead.

---

- Restore the jQuery UI Menu widget after upgrading to a Drupal version where it was removed from core.
- Attach the `jquery_ui_menu/menu` asset library from a custom module's render array.
- Attach the library from a theme's `*.libraries.yml` via a dependency.
- Satisfy a contrib module that still declares a dependency on the jQuery UI Menu library.
- Provide the menu widget required by jQuery UI Autocomplete's dropdown list.
- Keep a legacy custom widget working without rewriting it during a migration.
- Build a hierarchical navigation menu using the jQuery UI Menu JavaScript API.
- Add keyboard-navigable menus to an administrative form.
- Supply the menu component to a decoupled admin tool bundled with a site.
- Avoid bundling a private copy of jQuery UI in each module by sharing one library.
- Pin a known jQuery UI Menu version across a multi-site install.
- Ensure `jquery_ui` core assets load before the menu component via the declared dependency.
- Support context menus in a custom Drupal back-office screen.
- Enable flyout submenus in a legacy theme component.
- Provide the library on Drupal 9.2, 10 and 11 from a single module.
- Let a module author target the Drupal library ID rather than a CDN URL.
- Gradually deprecate jQuery UI usage by isolating it to modules that require it.
- Keep behavior identical to old core jQuery UI while planning a rewrite.
- Reference the menu widget from a Layout Builder custom block's attached library.
- Ship the menu component as a Composer-managed dependency of a distribution.
