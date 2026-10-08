# Configuration

The whole module is one form with two code editors. Whatever you save here is
written to files and loaded on every page of your default theme.

## Open the editors

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → Development → Additional JS CSS**, or navigate directly
   to `/admin/config/development/additional-js-css`.

## The two editors

- **CSS editor** — paste custom CSS here. On save it's written to
  `public://additional_js_css/style.css` and attached to the page head as a
  `<link rel="stylesheet">`. Use it for design tweaks, spacing fixes, hiding an
  element, and similar styling.
- **JavaScript editor** — paste custom JavaScript here. On save it's written to
  `public://additional_js_css/script.js` and attached to the head as a
  `<script src>`. Use it for analytics snippets, small widgets, or behavior
  tweaks.

Both textareas are resizable (that's what the jQuery UI Resizable dependency is
for), so you can drag them larger while working on a longer snippet. When you
reopen the form, it reloads whatever you previously saved so you can keep editing.

## Save and clear caches

Click **Save configuration**. As the form's own help text notes, you should
**clear the site caches** for changes to take effect — the attached files are
cached like other assets.

```bash
drush cr
```

Reload a front-end page on your default theme and your CSS/JS is now active.

## Good to know

- **Default theme only.** The files are attached only when the active theme is
  your configured **default** theme, so admin-theme pages are unaffected.
- **Loaded last.** The assets are added with a very high weight so they load after
  the theme's own CSS/JS — handy when you're overriding existing styles.
- **The files are world-readable.** They sit in the public files directory, so
  don't put anything secret in them.
- **Not exported config.** The code lives in files, not in exportable
  configuration, so back the files up if they hold tweaks you can't easily
  recreate. For anything permanent, prefer real theme assets under version
  control.
