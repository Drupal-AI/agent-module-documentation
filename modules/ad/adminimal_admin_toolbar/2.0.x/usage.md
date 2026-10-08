Adminimal Admin Toolbar restyles the core/Admin Toolbar admin toolbar with the minimalist "Adminimal" look-and-feel. It is a pure CSS/library layer that attaches its own stylesheets to the existing toolbar — it adds no new toolbar functionality of its own.

---

The module is inspired by the "Adminimal Administration Menu" and gives the Admin Toolbar module a dark, minimalist visual style. It ships three stylesheets (a main toolbar restyle, a `toolbar.override.css` that tones down core toolbar borders/shadows, and an Open Sans webfont file) exposed as two libraries: `adminimal_admin_toolbar/adminimal-admin-toolbar` and `adminimal_admin_toolbar/google-fonts`. A `hook_page_attachments_alter()` attaches these libraries globally, but only for users who hold the core `access toolbar` permission, so the styling never loads for anonymous visitors. A `hook_preprocess_html()` adds an `adminimal-admin-toolbar` body class that scopes all of the CSS, and a `hook_toolbar_alter()` tags the user tab with a `user-toolbar-tab` class so it can be pushed to the right. It requires the contributed `admin_toolbar` module (which in turn pulls in core Toolbar). The only configuration is a single checkbox, "Avoid loading Open Sans font," stored as `avoid_custom_font` in the `adminimal_admin_toolbar.settings` config object and edited at **Admin → Configuration → User interface → Adminimal Admin Toolbar** — useful when a site's language is poorly served by Open Sans (e.g. Japanese). Because it is a theme layer rather than a feature module, enabling it is essentially the whole setup: download, enable, done.

---

- Give the Drupal admin toolbar a dark, minimalist "Adminimal" appearance.
- Restyle an existing Admin Toolbar install without switching admin themes.
- Apply a consistent toolbar look regardless of which admin theme is active.
- Replace core toolbar borders and drop shadows with a flatter design (`toolbar.override.css`).
- Load the Open Sans webfont for the toolbar typography.
- Disable the Open Sans font download for languages Open Sans supports poorly (Japanese, etc.) via the `avoid_custom_font` setting.
- Move the user account tab to the right side of the toolbar (`user-toolbar-tab` class).
- Style the toolbar only for authenticated users who have the `access toolbar` permission.
- Keep the restyle out of the front end for anonymous visitors automatically.
- Pair with `admin_toolbar` (and its `admin_toolbar_tools` submodule) to get styled drop-down admin menus.
- Deploy a uniform admin-toolbar aesthetic across many sites by simply enabling the module.
- Scope all custom CSS behind the `adminimal-admin-toolbar` body class to avoid leaking styles.
- Avoid putting toolbar styling in a theme (which conflicts with Admin Toolbar) by using a module instead.
- Toggle the module on/off to A/B the default vs. Adminimal toolbar look.
- Ship the `avoid_custom_font` preference as configuration between environments.
- Provide editors with a higher-contrast dark toolbar for readability.
- Use as a lightweight branding touch on the administrative UI.
- Add the toolbar styling globally without editing any template files.
- Rely on the module's libraries instead of hand-writing toolbar CSS overrides.
- Restyle the toolbar on Drupal 8, 9, 10, or 11 (broad core compatibility).
- Enable via Composer (`drupal/adminimal_admin_toolbar`) as a drop-in dev release.
