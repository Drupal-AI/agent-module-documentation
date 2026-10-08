<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Migration Example (ai_migration_example) submodule

Ships runnable sample migrations that demonstrate the `ai` data parser. Lives at `modules/ai_migration_example/` inside the parent project (no separate top-level doc dir; documented here). Version 1.0.0-rc1, core `^10 || ^11`, package Migration.

## Dependencies
`ai_migration:ai_migration`, core `media` + `media_library`, `migrate_plus:migrate_plus`, `migrate_file:migrate_file` (the `image_import` process plugin).

## What it installs
- **Content types** (`config/optional/node.type.*`): `simple_content_migration` and `complex_content_migration`, with their fields, storages, form/view displays and base-field overrides (e.g. `promote`/`status`).
  - simple: `field_author`, `field_post_date`, `field_post_content`, `field_publishing_information`.
  - complex: `field_cover` (media), `field_description`, `field_publisher`, `field_subjects` (taxonomy).
- **Vocabulary** `subjects` (`config/install/taxonomy.vocabulary.subjects.yml`).
- **hook_install** (`ai_migration_example.install` → `ai_migration_example.module::_ai_migration_example_add_subject_terms()`): seeds the `subjects` vocabulary with terms "Fiction" and "Science fiction" (idempotent; created via `Term::create()` at install). A `post_update` hook is also present.
- **hook_help** returns a one-line static string.

## Sample migrations (`migrations/`)
Loaded by Migrate Plus (the module has no `migration_group`; run with `drush migrate:import <id>` or the UI).
- **`simple_content_migration`** — two CivicActions accessibility blog posts → `node:simple_content_migration`. `html_processor` extracts `head` + `#main-content`, `head_filter: true`, `minify: true`, sanitizer drops `style`. Process maps `attributes/title`, `attributes/field_author`, `attributes/field_post_date/value`, `attributes/field_publishing_information/value`, `attributes/field_post_content/value`; text fields use format `basic_html`; `status` defaults to **0** (unpublished).
- **`complex_content_migration`** — two OpenLibrary works → `node:complex_content_migration`. Container `.bookCover` + `.editionAbout`, a `strip_regex` for author-bio divs, sanitizer `allowElement` for custom web components. Maps title, `field_description` (basic_html), `field_publisher`, `field_subjects` via `sub_process`+`entity_generate` (taxonomy_term/subjects), and `field_cover` via `migration_lookup` into the media migration. `status` defaults to 0. Depends on `complex_content_migration_media`.
- **`complex_content_migration_media`** — same URLs, `item_selector: /relationships/field_cover/data/0` → `entity:media` (image bundle). Uses migrate_file's `image_import` to pull the AI-extracted cover `uri` into `public://images/book_covers/`; `status` 1.

## Usage as a template
Copy `simple_content_migration.yml` into your own module, change `urls`, `types` (your `entity_type:bundle`), the `ai.model`/`prompt`/`html_processor` blocks, and the `process` field map. See [data-parser.md](../plugins/data-parser.md).

## Notes
- The example URLs point at third-party sites (accessibility.civicactions.com, openlibrary.org); running the examples fetches those pages and sends their cleaned HTML to your AI provider.
- Imported nodes default to unpublished with the `basic_html` text format, so extracted content is filter-sanitized and reviewed before going live; the media example writes cover images into the public files directory.
