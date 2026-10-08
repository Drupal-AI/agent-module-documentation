<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Chophper (chophper) — agent index

HTML-aware text-truncation **field formatters**. Two plugins that extend core's Text formatters
but delegate the actual truncation to the `code-atlantic/chophper` PHP library, which parses the
field HTML with a DOM/HTML5 parser and truncates it while keeping tags balanced.

- **Both formatters, every setting, the render/pre-render mechanism, and config export** →
  [fields/formatters.md](fields/formatters.md)

## What it actually is

- Package `Custom`. Core `^10 || ^11`. Version `1.0.x` (1.0.0-rc1, not security-advisory covered).
- Depends on core **`text`** (module) and the **`code-atlantic/chophper`** Composer library
  (declared in `composer.json` `require`).
- Two field-formatter plugins in `src/Plugin/Field/FieldFormatter/`:
  - **`chophper_trimmed`** — "Trimmed (Chophper)", class `ChophperTrimmedFormatter` extends core
    `TextTrimmedFormatter`. Field types: `text`, `text_long`, `text_with_summary`.
  - **`chophper_summary_or_trimmed`** — "Summary or trimmed (Chophper)", class
    `ChophperSummaryOrTrimmedFormatter` extends core `TextSummaryOrTrimmedFormatter`.
    Field type: `text_with_summary` only.
- **No** routes, permissions, services (`*.services.yml`), config objects (`config/install`),
  Drush commands, hooks (`.module`) or install file. Only config **schema** for the two formatter
  settings (`config/schema/chophper.schema.yml`).

## Mechanism (from source)

- Each formatter's `viewElements()` builds a `#type => 'processed_text'` element (so the text
  format's filters run first), then appends its own `preRenderSummary` to `#pre_render` and
  stashes `#chophper_ellipsis`, `#chophper_truncate_by`, `#chophper_preserve_words` and
  `#text_summary_trim_length` (= the `trim_length` setting).
- `preRenderSummary()` takes the already-filtered `$element['#markup']` and replaces it with
  `Chophper\Full::truncate($markup, $trim_length, ['ellipsis'=>…, 'truncateBy'=>…, 'preserveWords'=>…])`.
- `chophper_summary_or_trimmed` first checks `$item->summary`; if non-empty it renders the summary
  verbatim and skips truncation, otherwise it truncates `$item->value` like the trimmed formatter.

## Settings (per view-display)

`trim_length` (core, relabeled "maximum number of units"), `truncate_by`
(`words` | `chars` | `sentences` | `blocks`, default `words`), `ellipsis` (default `…`),
`preserve_words` (bool, default FALSE — only meaningful for `chars`). Configured on
**Manage display** only. Details in [fields/formatters.md](fields/formatters.md).
