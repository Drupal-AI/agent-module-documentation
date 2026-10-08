# CKEditor Soft hyphen (shy) — agent index

Inserts an invisible soft hyphen (`&shy;`) into CKEditor 5 content and converts the stored
`<shy>` markup to the real character on output. Depends on `ckeditor5`. No config page
(`configure` null), no permissions, no schema, no Drush.

- **Enable it on a text format (toolbar button + filter) and the markup/character mapping** →
  [configure/text-format.md](configure/text-format.md)

Key facts:
- CKEditor 5 plugin declared in `shy.ckeditor5.yml` (`shy_shy`): toolbar item `shy`
  ("Soft hyphen"), allows the `<shy>` element, JS lib `shy/shy.ckeditor5`, and has
  `conditions: filter: shy_cleaner_filter` (button only shows when that filter is enabled).
- Filter plugin `shy_cleaner_filter` ("Cleanup SHY markup", TYPE_TRANSFORM_IRREVERSIBLE) in
  `src/Plugin/Filter/ShyCleanerFilter.php` replaces `<shy></shy>` (and legacy
  `<span class="shy">`) with the UTF-8 soft hyphen `"\xc2\xad"` via `Html::load()` + DOMXPath.
- No global configuration: setup is per-text-format only (`/admin/config/content/formats`).
- `src/Plugin/CKEditorPlugin/Shy.php` is a legacy CKEditor 4 plugin class, kept for old editors.
