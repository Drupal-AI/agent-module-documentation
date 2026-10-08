<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CRSIS (crsis) — agent index

Content **readability** scoring for published nodes. Analyzes each node's **body** field with the
**Flesch-Kincaid Reading Ease** formula (pure PHP, no external calls), maps the score to a grade,
generates suggestions, and shows it all on an **admin dashboard**. Package `Content`. Depends only
on core **`node`**. Core requirement `^10 || ^11 || ^12`, PHP `>=8.1`. License GPL-2.0-or-later.
Version 1.0.1.

- **The service, the scoring/grade/suggestion algorithm, and the dashboard** →
  [api/readability.md](api/readability.md)
- **Settings form, config object/schema, routes & permissions** →
  [config/settings.md](config/settings.md)

## What it actually is

- One service: **`crsis.readability`** → `ReadabilityService` (implements
  `ReadabilityServiceInterface`), `src/Service/`. Single public method `analyze(string $text): array`.
- One controller: `DashboardController::view()` at route **`crsis.dashboard`**
  (`/admin/content/crsis-dashboard`, permission **`access crsis dashboard`**). Loads the 50 most
  recently changed published nodes (`accessCheck(TRUE)`), scores each body, renders `#theme =>
  'crsis_dashboard'`.
- One settings form: `CrsisSettingsForm` (`ConfigFormBase`) at route **`crsis.settings`**
  (`/admin/config/content/crsis`, permission **`administer crsis`**), editing config object
  **`crsis.settings`**.
- Config object `crsis.settings`: `enable` (bool, default TRUE), `minimum_score` (int, default 60).
  Schema in `config/schema/crsis.schema.yml`, install defaults in `config/install/crsis.settings.yml`.
- One theme hook `crsis_dashboard` (`crsis.module`), template `templates/crsis-dashboard.html.twig`.
- One asset library `crsis/crsis_dashboard` (`css/dashboard.css`, `js/readability.js`; deps
  `core/drupal`, `core/once`).
- Two permissions (`crsis.permissions.yml`): `access crsis dashboard`, `administer crsis`
  (restricted). No entities, no plugin types, no Drush, no hooks beyond `hook_theme()`.

## Mechanism (from source)

- `analyze()` trims/`strip_tags()` the text, counts words via `str_word_count()`, sentences via
  `preg_match_all('/[.!?]+/', …)` (floored at 1), and syllables via `countSyllables()` (vowel-group
  count per word, minus a trailing silent `e`, floored at 1 per word).
- Score = `206.835 - 1.015*(words/sentences) - 84.6*(syllables/words)`, rounded to 2 dp.
- `getGradeLabel()` buckets the score into 7 labels (>=90 Very Easy … <30 Very Difficult).
- `getSuggestions()` reads `crsis.settings:minimum_score` and appends tips when the score is below
  the threshold, average sentence length > 20 words, average syllables/word > 1.6, or word count < 50.
- The dashboard only *reads* nodes and config; nothing here mutates content or accepts request input
  beyond the route itself.

## Notes

- Only the node **body** field is analyzed; nodes without a non-empty `body` score as empty text
  (`grade => N/A`). Analysis is English-oriented (Latin vowels/silent-e heuristic).
- When `enable` is FALSE the dashboard still renders but shows a warning linking to settings; the
  `enable` flag does not stop the scoring loop.
