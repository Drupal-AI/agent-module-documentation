<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bible (bible) — agent index

Imports **Bible Context (.bc) translations** into content entities and serves a native reading,
comparison, search, and reference UI. Package **Church**. Core `^10.1 || ^11 || ^12`,
GPL-2.0-or-later. Depends on core **field, file, filter, text, user, views**. No composer runtime
requirements, no Drush, no submodules.

## What it provides

- **Content entities** (`src/Entity/`): `bible` (translation: name, shortname, langcode, version),
  `bible_book` (bible ref, code, name, shortname, number, chapters), `bible_verse` (bible+book refs,
  chapter, verse, text, linemark, super/subscription, normalized `search_text`),
  `bible_concordance` (Strong definitions), `bible_note` (user notes on verses). Base tables
  `bible`, `bible_book`, `bible_verse`, `bible_concordance`, `bible_note`.
- **Permissions** (`bible.permissions.yml`): `administer bible` (restricted), `administer bible imports`,
  `view bible entity`, `edit bible entity`, `delete bible entity`.
- **Reading routes** (shortname-based, all `_permission: view bible entity`): `/bible` redirect,
  `/bible/{bible}`, `/bible/{bible}/{book}`, `/bible/{bible}/{book}/{chapter}`, `/bible/multiread`,
  `/bible/search`, JSON `/bible/strong/{code}`.
- **Admin/import routes**: `/admin/content/bible/import` (+`/fetch-name` AJAX) under
  `administer bible imports`; settings at `/admin/structure/bible/*` under `administer bible`.
- **Services** (`bible.services.yml`): `bible.parser`, `bible.search`, `bible.search_query_parser`,
  `bible.search_highlighter`, `bible.verse_text_normalizer`, `bible.strong_code_normalizer`,
  `bible.route_subscriber`, and the `BibleHooks` OOP hook object.
- **Plugins**: Filter `bible_filter` ("Bible references as popups"); Blocks `bible_golden_verse`,
  `bible_search`.
- **Config**: `bible.settings` (`default_bible`, `show_multiread_bible_name`,
  `importer.github_repository`); three bundled Views (`bible_books`, `bible_verses`, `bible_notes`)
  and two entity actions (save/delete).

## Solution docs

- Entities, fields, storage schema, cascade delete, RouteSubscriber → [api/entities.md](api/entities.md)
- Import pipeline (upload / GitHub, parser, batch insert) → [api/import.md](api/import.md)
- Reading & Multi-Read routes/controllers/templates → [api/reading.md](api/reading.md)
- Keyword search service, query syntax, block, highlighter → [api/search.md](api/search.md)
- Strong concordance JSON lookup → [api/strong.md](api/strong.md)
- BLS reference filter + Golden Verse block → [plugins/filter-and-blocks.md](plugins/filter-and-blocks.md)
- Settings, config object & schema, install/updates → [config/settings.md](config/settings.md)
