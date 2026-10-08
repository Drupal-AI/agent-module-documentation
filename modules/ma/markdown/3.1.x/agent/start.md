<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Markdown — agent index

Parses Markdown to HTML through a **text-format filter**, a **service/Twig filter**, and a
pluggable **parser** system (CommonMark, Parsedown, PHP Markdown). Depends on core `filter`
plus PHP `dom`/`libxml`. Parser libraries are external Composer packages you install.

- **Enable the Markdown filter on a text format, choose a parser, the admin UI & permission**
  → [configure/filter.md](configure/filter.md)
- **The `markdown` service (parse/load/save) and the Twig `|markdown` filter/function** →
  [api/service.md](api/service.md)
- **The three plugin types (parser, extension, allowed_html) and how to add one** →
  [plugins/plugins.md](plugins/plugins.md)
- **Alter hooks** → [hooks/hooks.md](hooks/hooks.md)

Key facts:
- Filter plugin id `markdown` (title "Markdown", type MARKUP_LANGUAGE). Stored on a text
  format at `filters.markdown` with `status` and `settings.id` = the parser plugin id.
- Parser plugin ids seen on this site: `commonmark`, `commonmark-gfm`, `parsedown`,
  `parsedown-extra`, `php-markdown`, `php-markdown-extra` (plus `_missing_parser`).
- Service id `markdown` (`Drupal\markdown\Markdown`): `parse()`, `getParser()`, `load()`,
  `loadFile()`, `loadUrl()`, `save()`.
- Twig: `{{ text|markdown }}` filter and `markdown(text)` function.
- Admin: `/admin/config/content/markdown` (route `markdown.overview`, permission `administer
  markdown`); per-parser config route `markdown.parser.edit`.
- Plugin managers: `plugin.manager.markdown.parser` / `.extension` / `.allowed_html`.
