<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Additional JS CSS lets an administrator paste custom CSS and JavaScript that the module writes to files and attaches to every page on the default theme.

Use it for quick site-wide tweaks or third-party snippets without editing a theme, when you accept that this is admin-level code injection by design.

- Two editors (CSS and JS) with a resizable textarea (jQuery UI Resizable).
- Saves content to `public://additional_js_css/style.css` and `script.js`.
- Attaches the files via `hook_page_attachments()` on the default theme only.
- Restricted to the `administer site configuration` permission.

---

Install and configure:

- Enable `drush en additional_js_css` (pulls `jquery_ui_resizable`).
- Visit `/admin/config/development/additional-js-css`.
- Paste CSS and/or JS and save.
- Clear caches for changes to take effect (as the help text notes).

---

- Content is stored as flat files under `public://additional_js_css/`.
- `AdditionalJSCSSManager::saveAdditionalFile()` writes via the file system service.
- `getAdditionalFile()` reads existing content back into the form.
- Attachments are added with a very high weight (9999) so they load last.
- CSS is added as a `<link rel="stylesheet">`, JS as a `<script src>` in the head.
- Only applied when the active theme equals the configured default theme.
- The permission is site-config level: only trust operators who may already inject code.
- Files live in the public files directory and are world-readable by design.
- No user-facing input; only admins write the code.
- Treat this as equivalent to theme-level code access for threat modeling.
- Useful for analytics snippets, small design fixes, PoCs.
- Prefer real theme assets for anything permanent/version-controlled.
- Back up the files if they hold important tweaks (they are not exported config).
- Test on the default theme; admin theme pages are unaffected.
- Clear caches after each save.
