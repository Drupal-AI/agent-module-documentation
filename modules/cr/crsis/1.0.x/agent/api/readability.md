<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Readability service, algorithm & dashboard

## The service

- Service id **`crsis.readability`** (`crsis.services.yml`), class
  `Drupal\crsis\Service\ReadabilityService` implementing `ReadabilityServiceInterface`
  (`src/Service/`). Constructor arg: `@config.factory`.
- Single public method:

  ```php
  \Drupal::service('crsis.readability')->analyze(string $text): array;
  ```

  Returns an associative array:
  - `words` (int) — `str_word_count()` of the tag-stripped text.
  - `sentences` (int) — `preg_match_all('/[.!?]+/', $text)`, floored at 1.
  - `syllables` (int) — from `countSyllables()`.
  - `flesch_kincaid` (float) — the Reading Ease score, rounded to 2 dp.
  - `grade` (string) — human-readable label (translated).
  - `suggestions` (array) — list of translated suggestion strings.

  For empty/whitespace input it short-circuits to `words/sentences/syllables => 0`,
  `flesch_kincaid => 0`, `grade => 'N/A'`, `suggestions => []`.

## Algorithm (from `ReadabilityService`)

1. `analyze()` runs `trim()`, then `strip_tags()` so HTML markup does not inflate counts.
2. Words: `str_word_count($text)`. Sentences: count of `.`/`!`/`?` groups, `max(1, …)`.
3. Syllables (`countSyllables()`): split on whitespace, lowercase, strip non `a-z`, count
   `preg_match_all('/[aeiouy]+/', $word)` vowel groups, subtract 1 for a trailing silent `e`
   (`/[^aeiouy]e$/`), floor each word at 1.
4. Score (Flesch-Kincaid Reading Ease):
   `206.835 - 1.015*(words/sentences) - 84.6*(syllables/max(1,words))`, `round(…, 2)`.
5. Grade (`getGradeLabel()`): `>=90` Very Easy, `>=80` Easy, `>=70` Fairly Easy, `>=60` Standard,
   `>=50` Fairly Difficult, `>=30` Difficult, else Very Difficult.
6. Suggestions (`getSuggestions()`), appended when true:
   - score `<` `crsis.settings:minimum_score` (default 60) → "below the minimum threshold" tip;
   - average sentence length (`words/sentences`) `> 20` → "break long sentences" tip;
   - average syllables/word (`syllables/words`) `> 1.6` → "use simpler words" tip;
   - `words < 50` → "content is very short" note;
   - if none of the above fired → "Content readability looks good!".

The heuristic is English/Latin-oriented; non-English or symbol-heavy text scores approximately.

## The dashboard

- Route **`crsis.dashboard`** → `DashboardController::view()` at `/admin/content/crsis-dashboard`,
  permission **`access crsis dashboard`** (`crsis.routing.yml`). Menu link under *Content*
  (`crsis.links.menu.yml`), weight 10.
- `view()` reads `crsis.settings:enable`; if FALSE it adds a warning message linking to
  `crsis.settings` (but still proceeds). It queries node storage:
  `getQuery()->accessCheck(TRUE)->condition('status', 1)->sort('changed', 'DESC')->range(0, 50)`,
  loads the nodes, and for each takes `$node->get('body')->value` (only if `body` exists and is
  non-empty) into `analyze()`.
- Returns `#theme => 'crsis_dashboard'` with `#data` (`message`, `enabled`) and `#results`
  (per node: `nid`, `title`, `type`, `analysis`), attaching library `crsis/crsis_dashboard`.
- Template `templates/crsis-dashboard.html.twig` computes summary cards (total, average score,
  good `>=60` vs. low `<60` counts), a legend, and a table (Title link, Type, Words, Score badge,
  Grade, Suggestions). Twig auto-escapes titles and suggestion text. CSS `css/dashboard.css`,
  behavior `js/readability.js` (`Drupal.behaviors.crsisDashboard`, uses `core/once`) that adds a
  highlight class to `.crsis-score--low` rows.

## Theme hook

`crsis_theme()` in `crsis.module` registers `crsis_dashboard` with variables `data` (default `[]`)
and `results` (default `[]`). No other hooks are implemented.
