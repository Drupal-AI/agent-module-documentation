<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Open Y Programs Search (openy_programs_search) — agent index

Open Y / YMCA distribution module (project `program_search`). Provides a single **block**,
`programs_search_block`, that lets visitors drill through Daxko program data (locations →
schools/categories → programs → rates/sessions) and returns a **registration deep link** into the
branch's Daxko site. Core `^11`. License GPL-2.0-or-later. Version 2.0.0.

Depends on **`daxko`** (the authenticated Daxko API client, service `daxko.client`) and
**`openy_socrates`** (provides `OpenyCronServiceInterface` and the `openy_cron_service` tag).
Also requires `symfony/dom-crawler` (`^7.2`) for HTML scraping.

- **The block, the two search flows, and the `DataStorage` service** →
  [blocks/programs_search.md](blocks/programs_search.md)
- **Admin settings form, config object and every key** →
  [config/settings.md](config/settings.md)

## What it actually provides

- **Block plugin** `ProgramsSearchBlock` (id `programs_search_block`, category *Forms*) in
  `src/Plugin/Block/ProgramsSearchBlock.php`. Its `build()` renders the form
  `ProgramsSearchBlockForm`; `blockForm()`/`blockSubmit()` store per-block `enabled_locations` and
  `enabled_categories`.
- **Form** `ProgramsSearchBlockForm` (`src/Form/ProgramsSearchBlockForm.php`, form id
  `programs_search_block_form`) — an AJAX, step-based selector with a Child Care branch and an adult
  Programs branch. `submitForm()` is a no-op (`@todo`); the result is a rendered registration link.
- **Service** `openy_programs_search.data_storage` → `DataStorage` (`src/DataStorage.php`),
  implementing `DataStorageInterface` and `OpenyCronServiceInterface`. Wraps `daxko.client`, the
  `openy_programs_search` cache bin, core `http_client` (Guzzle), a `Symfony\...\DomCrawler\Crawler`
  and `config.factory`. Tagged `openy_cron_service` (periodicity 43200s ≈ 12h);
  `runCronServices()` calls `resetCache()` + `warmCache()`.
- **Settings form** `SettingsForm` (`src/Form/SettingsForm.php`) at route
  `openy_programs_search.settings` → `/admin/openy/integrations/daxko/programs-search`, permission
  **`administer programs search`**. Menu link under Open Y Daxko integrations.
- **Permission**: `administer programs search` (`openy_programs_search.permissions.yml`).
- **Config**: `openy_programs_search.settings` (install defaults in `config/install/`). No config
  schema file ships. No entities, no custom plugin types, no Drush, no `.install`, empty `.module`.

## Data & external calls (from source)

- Structured Daxko data via `daxko.client`: `getBranches`, `getPrograms`, `getSessions`,
  `getChildCarePrograms`.
- HTML scraping via `DataStorage::getDaxkoPageSource()` — Guzzle GET (two requests: one to collect
  `Set-Cookie`, one with a rebuilt `CookieJar`), then DomCrawler `filter()` for schools, rate rows
  (`#session-list-table tr.childcare-rate`) and category lists. URLs are built from admin config
  (`base_url` + path templates with `{{ client_id }}` / `{{ program_id }}` / `{{ branch_id }}`
  token replacement), not from visitor input. Default Guzzle TLS verification (not disabled).
- Everything memoized in the `openy_programs_search` cache bin keyed by `__METHOD__` + args.
