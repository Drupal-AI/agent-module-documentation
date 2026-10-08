# CKEditor Accessibility Checker — agent index

Adds an "Accessibility Checker" toolbar button to CKEditor 5. Clicking it runs the bundled
**Sa11y** engine over the editable content and reports accessibility issues inline. Pure
front-end plugin — no PHP, no config page (`configure` null), no permissions, no Drush, no schema.
Depends on core `ckeditor5`. All assets self-hosted (no CDN).

- **Enabling it on a text format + the CKEditor5 plugin/library wiring** →
  [configure/setup.md](configure/setup.md)

Key facts:
- CKEditor 5 plugin declared in `ckeditor_a11ychecker.ckeditor5.yml`: JS plugin
  `a11ychecker.A11ychecker`, toolbar item id `a11ychecker`, `elements: false` (adds no markup).
- Libraries: `ckeditor_a11ychecker/a11ychecker` (Sa11y `sa11y/*` + `js/build/a11ychecker.js`, editor
  runtime) and `ckeditor_a11ychecker/admin.a11ychecker` (admin CSS while configuring a format).
- Configure by dragging the **Accessibility Checker** button into a format's CKEditor 5 toolbar at
  `/admin/config/content/formats`. No other settings.
