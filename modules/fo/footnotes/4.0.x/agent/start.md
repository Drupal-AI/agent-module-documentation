# Footnotes — agent index

Numbered footnotes in rich text: a **CKEditor 5 button** inserts a `<footnotes>` element; the
**`filter_footnotes`** text filter renders references + a notes list at display time. Config
lives on the **text format** (no configure route, no permissions). Depends on `ckeditor5`,
`editor`, `media`. Provides a Drush command and a Search API processor.

- **Turn footnotes on for a text format / editor (filter + toolbar button + shipped format)** →
  [configure/setup.md](configure/setup.md)
- **The `filter_footnotes` filter and all its settings (numbering, collapse, dialog, footer)** →
  [plugins/filter.md](plugins/filter.md)
- **Footnotes Group block + the "footnotes" extra field (render notes outside the body)** →
  [plugins/block.md](plugins/block.md)
- **Drush `footnotes:upgrade-3-to-4` (migrate 3.x content) and its alter hook** →
  [drush/upgrade.md](drush/upgrade.md)
- **Overridable Twig templates / theme hooks** → [theming/templates.md](theming/templates.md)

Key facts:
- Filter id `filter_footnotes` (provider `footnotes`, TYPE_TRANSFORM_IRREVERSIBLE). CKEditor 5
  plugin id `footnotes_footnotes`, toolbar item `footnotes`, class
  `\Drupal\footnotes\Plugin\CKEditor5Plugin\Footnotes`.
- Ships an **optional** ready-made format `filter.format.footnote` + `editor.editor.footnote`
  (CKEditor 5) — installed only if not present.
- Filter settings: `footnotes_collapse`, `footnotes_css`, `footnotes_dialog`,
  `footnotes_dialog_prevent_bubbling`, `footnotes_footer_disable`,
  `footnotes_preview_show_text`, `footnotes_preview_character`.
- Routes `footnotes.dialog` / `footnotes.preview` back the editor UI (custom access).
- Search API processor `footnotes_ignore_citations`; Drush `footnotes:upgrade-3-to-4`.
