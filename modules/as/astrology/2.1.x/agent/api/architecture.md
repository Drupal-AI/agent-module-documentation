<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Astrology — data model, services, block, hooks

All source under `web/modules/contrib/astrology/`.

## Database schema (`astrology.install` → `astrology_schema()`)

Three custom tables (no config entities, no content entities):

- **`astrology`** — a named astrology (e.g. "Zodiac"). Columns: `id` (serial PK), `name`
  (varchar 255), `enabled` (tinyint, 0/1), `about` (big text), `about_format` (varchar, default
  `full_html`).
- **`astrology_signs`** — a sign belonging to one astrology. Columns: `id` (serial PK),
  `astrology_id` (int, FK by convention), `name` (varchar 255), `icon` (varchar 255 — a module
  file path), `date_range_from` / `date_range_to` (varchar 20, `"M/D"` e.g. `3/21`),
  `about_sign` (big text), `about_sign_format` (varchar, default `full_html`).
- **`astrology_text`** — one horoscope entry per sign/format/date. Columns: `id` (serial PK),
  `astrology_sign_id` (int), `format_character` (varchar 5 — one of PHP date chars `z`/`W`/`n`/`o`),
  `value` (int — the day-of-year / week / month / year number the text is keyed to), `post_date`
  (int unix timestamp), `text` (big text), `text_format` (varchar, default `full_html`). Indexes on
  `format_character` and `value`.

`astrology_install()` seeds astrology id **1 = "Zodiac"** (`enabled = 1`) and inserts the 12 signs
with hard-coded date ranges, `img/zodiac/<Sign>.svg.png` icons and long HTML `about_sign` blurbs.
No `hook_uninstall` / no update hooks ship in this version.

## Services (`astrology.services.yml`)

### `astrology.core` — `Services\AstrologyCoreService`
Args `@database`, `@config.factory`, `@cache_tags.invalidator`. All queries use the Drupal DB API
(`select`/`insert`/`update`/`delete` with `->condition(...)` placeholders). Key methods:

- Astrologies: `addAstrology`, `updateAstrology`, `getAllAstrology`, `getAstrologyArray`,
  `getAstrology`, `disableAllAstrology`, `enableAstrology`, `checkForDuplicateAstrologyName`,
  `deleteAstrology`.
- Default-astrology bookkeeping: `updateDefaultAstrology($id,$status,$op)` +
  private `updateAstrologyConfigSettings()` — keeps exactly one astrology `enabled` and writes the
  chosen id into `astrology.settings:astrology`.
- Signs: `addAstrologySign`, `updateAstrologySign`, `getAstrologySigns($astrology_id,$sign_name?,$sign_id?)`,
  `getAstrologyListSignArray`, `checkForDuplicateSignName`, `deleteSign`.
- Text: `astrologyAddSignText`, `astrologyUpdateSignText`, `updateText`, `getAstrologicalSignText`,
  `getAllTextForAllSigns` (joins `astrology`+`astrology_signs`+`astrology_text`), `getAllTextForSign`,
  `deleteAllText`, `isValidText` (throws `AccessDeniedHttpException` if text_id not under sign_id).
- Mutations that affect display call `cacheTagsInvalidator->invalidateTags(['astrology_block'])`.

### `astrology.utility` — `Services\AstrologyUtilityService`
Arg `@config.factory`. Pure date/format helpers, no DB. Notable:
- `getFirstLastDow($ts)` — first (Mon) / last (Sun) day-of-week timestamps.
- `astrologyCheckValidDate($formatter,$n)` / `astrologyCheckNextPrev($formatter,$n)` — bound the
  `next_prev` number to a valid day-of-year (≤365/364), week (≤53/52), month (1–12) or ±1 year;
  the controller uses these to reject out-of-range URLs with a 404.
- `getFormatDateValue`, `getTimestamps` (`strtotime`), `getDoy`, `getCdate`, `getMonthsArray`,
  `getDaysArray`, `getYearsArray`.

## Block plugin (`src/Plugin/Block/AstrologyBlock.php`)

`@Block(id="astrology", admin_label="Astrology")`. `build()` reads
`astrology.settings:astrology` + `:format_character`, calls
`astrology.core->getAstrologySigns($astrology_id)`, and returns `#theme => 'astrology'` with the
signs and formatter, attaching library `astrology/astrology.module`. `getCacheTags()` merges the
`astrology_block` tag so `enableAstrology` / `updateAstrologySign` / settings changes bust it.
`build()` also sets a `blank_msg` only when the current user `hasPermission('Administrator')`.

## Hooks & theme (`astrology.module`)

- `astrology_help()` — help text on `help.page.astrology`.
- `astrology_theme()` — registers four templates in `templates/`: `astrology` (block list),
  `astrology-text` (horoscope page), `astrology-sign-text` (sign details), `astrology-dob-sign`
  (birth-sign result). Templates render sign/horoscope HTML that was authored by administrators.

## Controller (`Controller\AstrologyController`)

Public: `astrologyListTextSignPage` (validates `formatter ∈ {day,week,month,year}` and `next_prev`
range, then renders the sign's text for that period with prev/next links), `astrologySignDetailsPage`,
`astrologicalSignPage`, and the DOB form route. Admin: `astrologyConfig` (astrology table +
`AstrologyConfig` settings form), `astrologyListSign`, `astrologySignTextSearch`. Missing rows throw
`NotFoundHttpException`. Icons are emitted through `t('<img src=":src" .../>', ...)` (placeholders
escaped) using `file_url_generator->generateAbsoluteString($row->icon)`.
