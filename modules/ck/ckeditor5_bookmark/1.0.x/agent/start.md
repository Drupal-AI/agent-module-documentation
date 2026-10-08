# CKEditor 5 Bookmark — agent index

Registers the native CKEditor 5 Bookmark (anchor) button that core ships but leaves disabled. Pure
config glue: no PHP, no services, no permissions, no config schema. Requires core `ckeditor5`.

- **Enabling the button on a text format and the CKEditor5 plugin definition** →
  [configure/toolbar.md](configure/toolbar.md)

Key facts:
- Plugin def `ckeditor5_bookmark_enable` in `ckeditor5_bookmark.ckeditor5.yml` maps CKEditor plugin
  `bookmark.Bookmark` → Drupal toolbar item `bookmark` (label "Bookmark"); allows element `<a id>`.
- Libraries: `ckeditor5_bookmark/ckeditor5.bookmark` (JS, points at core's
  `/core/assets/vendor/ckeditor5/bookmark/bookmark.js`) and `ckeditor5_bookmark/internal.admin.bookmark`
  (admin CSS).
- Needs Drupal ≥10.4 / ≥11.1 (bundles CKEditor 5 v44.0.0).
