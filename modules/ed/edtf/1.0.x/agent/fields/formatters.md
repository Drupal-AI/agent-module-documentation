<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# EDTF display formatters

Two formatters ship for the `edtf` field type. Both live in
`src/Plugin/Field/FieldFormatter/` and extend core `FormatterBase`. Neither declares settings.
`edtf_humanizer` is the field type's `default_formatter`.

## EDTF Humanizer — `edtf_humanizer`

`EDTFHumanizerFormatter.php`.

```
@FieldFormatter( id = "edtf_humanizer", label = "EDTF Humanizer", field_types = { "edtf" } )
```

- `viewElements($items, $langcode)` obtains `Helper::getParser()` and
  `Helper::getHumanizer($langcode)` (a per-language humanizer from the library).
- For each item it parses the stored `value`, gets the parsed value via `getEdtfValue()`, and
  renders `['#markup' => $humanizer->humanize($edtfValue)]` — a readable, language-aware phrase
  (e.g. *"circa 1600"*, *"an unknown day in December 2023"*). Output is produced by the
  `professional-wiki/edtf` humanizer, keyed to the display language passed in `$langcode`.

Use this for public-facing display of imprecise dates.

## Plain — `edtf_plain`

`EDTFPlainFormatter.php`.

```
@FieldFormatter( id = "edtf_plain", label = "Plain", field_types = { "edtf" } )
```

- `viewElements()` simply renders the raw stored string for each item:
  `['#markup' => $item->value]`. No parsing, no humanizing — the EDTF string is shown exactly as
  stored (e.g. `2023-12-XX`). Useful for cataloguers who need the canonical machine value.

## Selecting a formatter

*Structure → (bundle) → Manage display* → set the field's format to **EDTF Humanizer** or
**Plain**. Config equivalent:

```bash
drush cset core.entity_view_display.node.article.default \
  content.field_when.type edtf_humanizer -y   # or edtf_plain
drush cr
```

Neither formatter exposes a settings form or a `settingsSummary()`, so there is nothing further to
configure.
