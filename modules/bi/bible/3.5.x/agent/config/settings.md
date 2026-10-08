<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings, config & install

## Enable
`drush en bible` (or via UI). Core deps auto-enable: field, file, filter, text, user, views.
No composer runtime requirements. After enabling, import at least one translation
(see [../api/import.md](../api/import.md)) before the reading/search UI is usable.

## Config object `bible.settings` (`config/install/bible.settings.yml`, schema `config/schema/bible.schema.yml`)
- `default_bible` (string) — entity id of the default translation. Install default `'1'`.
- `show_multiread_bible_name` (bool) — show the Bible shortname before each verse line in Multi-Read.
  Default `false`.
- `importer.github_repository` (string) — `owner/repo` used by the import form's GitHub download
  table. Default `dieuwedeboer/bible-context`.

## Settings form — `BibleSettingsForm` (`src/Form/BibleSettingsForm.php`, `ConfigFormBase`)
Route `entity.bible.settings` `/admin/structure/bible/bibles`, permission **`administer bible`**.
Exposes `default_bible` (required select of imported Bibles) and `show_multiread_bible_name`. The same
form class is also mounted at the `books`/`verses`/`notes` settings tabs (Field UI base routes). A
menu block page lives at `/admin/structure/bible` (`bible.menu_block_page`, `administer bible`).

## Permissions (`bible.permissions.yml`)
`administer bible` (restrict access) · `administer bible imports` · `view bible entity` ·
`edit bible entity` · `delete bible entity`.

## Bundled config
- Views: `views.view.bible_books`, `bible_verses`, `bible_notes` (the verses view is access-gated to
  `view bible entity`).
- Actions: `system.action.bible_save_action`, `bible_delete_action`.

## Install / update hooks (`bible.install`)
- `bible_update_10001` — adds the `(bible,book,chapter,verse)` unique key and `(bible,book,chapter)`
  index to `bible_verse` (after checking for pre-existing duplicates); drops obsolete format indexes.
- `bible_update_10002` — sets the `bible_verses` view to require `view bible entity`.
- `bible_update_10003` — installs the `search_text` base field and back-fills it in batches of 1000
  via `bible.verse_text_normalizer`.
