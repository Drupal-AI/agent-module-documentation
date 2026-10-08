# IB: CKEditor WYSIWYG integration (ib_dam_wysiwyg) — agent index

**Deprecated** submodule of `ib_dam` (deprecated in 4.x/5.x, removed in 6.0.0). Legacy CKEditor
embedding for sites not using the Media suite. Prefer **ib_dam_media** instead.

- **The deprecated filter, its no-op behaviour, and the migration update** →
  [configure/deprecation.md](configure/deprecation.md)

Key facts:
- One text-format filter, id `ib_dam_wysiwyg` ("IntelligenceBank DAM WYSIWYG",
  `TYPE_MARKUP_LANGUAGE`). Its `process()` returns text **unchanged** and triggers an
  `E_USER_DEPRECATED` notice.
- `hook_requirements()` raises a runtime "deprecated" warning.
- Migration hook `ib_dam_wysiwyg_update_9000()`: removes the filter from all formats and
  converts old inline IB JSON markup into `<drupal-media>` tags (via ib_dam_media MediaStorage).
- No config, no schema, no permissions, no services. Depends on `field`, `filter`, `ib_dam`.
