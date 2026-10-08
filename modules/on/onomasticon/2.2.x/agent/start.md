<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Onomasticon (onomasticon) — agent index

A glossary **text-format filter** backed by a taxonomy vocabulary, plus a CKEditor "exclude from
glossary" button. Enable the filter `filter_onomasticon` on a text format, point it at a
vocabulary, and every rendered piece of text in that format has its glossary terms wrapped in a
`dfn`/`abbr`/`cite` tag carrying the term's definition (as a CSS tooltip, a `title` attribute, or an
ARIA-described element). Terms are matched **on the parsed HTML DOM** (`Masterminds\HTML5`), only
inside `#text` nodes and never inside tag names/attributes or a configurable list of disabled tags,
so markup is never corrupted.

The whole module is plugins: one `@Filter` plugin (`FilterOnomasticon`), a CKEditor 4 plugin and a
CKEditor 5 plugin (`glossaryExclude`) that wrap selected text in a `<nonomasticon>` element to
exclude it, and a CKEditor4→5 upgrade plugin. The `.module` adds `hook_theme` (template
`onomasticon`), an alter hook (`hook_onomasticon_terms_alter`), and two request-static cache
helpers. There is an optional soft integration with the **Synonyms** module.

- Depends on: nothing hard (info.yml has no `dependencies`). Soft: `synonyms` (used only when the
  `synonyms.provider_service` exists), `ckeditor5`/`ckeditor` (only for the exclude button).
- Core: `^9.3 || ^10 || ^11`. Package: `custom`. Requires the PHP **mbstring** extension.
- **No dedicated settings page / `configure` route.** All configuration is per text format, on the
  filter's settings form (`admin/config/content/formats/manage/{format}`).
- No permissions, no config schema, no Drush, no routes, no services, defines no plugin types.

## What you'd do → where

- **Turn the glossary on for a text format and tune matching/display** →
  [configure/filter.md](configure/filter.md)
- **Understand/override the rendered tooltip markup (the three implementation modes)** →
  [configure/filter.md](configure/filter.md)
- **Let editors exclude a passage from glossary processing (`<nonomasticon>`)** →
  [plugins/ckeditor.md](plugins/ckeditor.md)
- **Alter the set of glossary terms, or the theme hook / request caches** →
  [hooks/index.md](hooks/index.md)

## Key facts (real machine names)

- Filter plugin: **`filter_onomasticon`** (`src/Plugin/Filter/FilterOnomasticon.php`), title
  "Onomasticon Filter", `type = TYPE_TRANSFORM_IRREVERSIBLE`. Returns the text unchanged when
  `onomasticon_vocabulary` is empty (enabling it without picking a vocabulary is a silent no-op).
- Filter settings keys (defaults): `onomasticon_vocabulary` (""), `onomasticon_definition_field`
  ("description"), `onomasticon_definition_filters` (false), `onomasticon_tag` ("dfn"),
  `onomasticon_disabled` ("abbr audio button cite code dfn form meta object pre style script
  video"), `onomasticon_implement` ("extra_element"), `onomasticon_orientation` ("below"),
  `onomasticon_cursor` ("default"), `onomasticon_repetition` (""), `onomasticon_ignorecase` (false),
  `onomasticon_termlink` (false). Stored under `filters.filter_onomasticon.settings.*` on the
  `filter.format.{format}` config entity. **No config schema ships.**
- Theme hook: **`onomasticon`** → `templates/onomasticon.html.twig`; variables `tag`, `needle`,
  `description`, `implement`, `orientation`, `cursor`, `termlink`, `termpath`, `term`.
- Alter hook: **`hook_onomasticon_terms_alter(array &$terms)`** (invoked as
  `->alter('onomasticon_terms', $terms)` in `FilterOnomasticon::getTaxonomyTerms()`).
- Module functions: `onomasticon_get_term_cache()`, `onomasticon_set_term_cache($term_id)` (request
  `drupal_static`, used by the "prevent page repetition" mode); `onomasticon_help()`.
- CKEditor 5 plugin: definition `onomasticon.ckeditor5.yml` id **`onomasticon_glossary_exclude`**,
  toolbar item **`glossaryExclude`**, JS `glossaryExclude.GlossaryExclude`, model attribute /
  command `nonomasticon`, allowed element `<nonomasticon>`. CKEditor 4 plugin
  `@CKEditorPlugin(id = "nonomasticon")` (`OnomasticonExcludeCkeditorButton`, button `nonomasticon`).
  Upgrade path `@CKEditor4To5Upgrade(id = "nonomasticon")` maps button `nonomasticon` → `glossaryExclude`.
- Libraries (`onomasticon.libraries.yml`): `onomasticon/default` (front-end CSS
  `onomasticon.theme.css`, auto-attached by the template), `onomasticon/glossary_exclude`,
  `onomasticon/admin.glossary_exclude`.
- Cacheability: the `FilterProcessResult` adds cache tag **`taxonomy_term_list:{vocabulary}`**, so
  adding/editing a glossary term invalidates rendered text with no manual cache clear.

Performance note: every render in the format parses the body into a DOM and matches it against the
whole vocabulary, so it is not free on large vocabularies / long bodies — rely on the render cache.
