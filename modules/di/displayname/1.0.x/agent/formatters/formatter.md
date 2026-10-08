<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Formatter, format strings & markup

Source: `src/Plugin/Field/FieldFormatter/DisplayNameFormatter.php` and the parser
`src/DisplayNameFormatParser.php` (service `displayname.format_parser`). The core `string` formatter is also allowed
on `display_name` fields via `displayname_field_formatter_info_alter()`.

## Formatter `display_name_default`

`defaultSettings()`: `format => 'default'`, `markup => 'none'`, `list_format => ''`, `link_target => ''`, plus the
additional preferred/alternative reference settings. Config schema key `field.formatter.settings.display_name_default`.

`settingsForm()` selects:
- **format** — a named pattern from `displayname_get_custom_format_options()` (default, formal, first, last, full,
  alias). Each name maps to a format string in `displayname_get_format_by_machine_name()`
  (e.g. `default => 't+if+il'`, `formal => 't+il`).
- **list_format** — how multi-value fields are joined (from `displayname_get_custom_list_format_options()`).
- **markup** — one of the modes below (`DisplayNameFormatParser::getMarkupOptions()`).
- **link_target** (bundle fields only) — `_self` (entity URL) or an entity_reference / link field on the same
  entity, resolved by `getLinkableTargetUrl()` with `access('view')` checks; falls back to `Url::fromRoute('<none>')`.

`viewElements()` merges each item's columns with any parsed additional components, then either calls the list
formatter or, per delta, `parser->parse($item, $format, $this->settings)` and assigns the result to `#markup`.
(Note: the multi-value list path calls `$this->formatter->formatList(...)`, a property not defined on this alpha's
formatter class — leave `list_format` empty unless you have verified it on your build.)

## Format string mini-language (`DisplayNameFormatParser`)

`parse()` runs `format()` over a pattern of single-character tokens. Key tokens (`tokenHelp()`):
`t` title, `f` first, `m` middle, `l` last, `q` preferred, `p` preferred-or-first, `n` nickname/alias, `u` full,
`a` alternative; initials `x`/`y`/`z`/`w`/`v` (first letter) and `I`/`J`/`K`/`M` (all-word initials);
`i`/`j`/`k` separators 1/2/3; `d`/`D`/`e`/`E` conditional first-or-last selectors.

Modifiers apply to the next token: `L` lower, `U` upper, `F` ucfirst, `G` ucwords, `T` trim,
`S` HTML-escape, `B` first word, `b` last word. Conditionals: `+` (both neighbours non-empty), `-` (previous
non-empty), `~` (previous empty), `=` (next non-empty), `^` (next empty), `|` (previous else this). `(` … `)` group;
`\` escapes the next character literally.

## Markup modes and escaping

`parse()` chooses a wrapper by the `markup` setting:
- `none` (default) — the assembled string is returned as `HtmlEscapedText` (escaped on output).
- `simple` / `microdata` / `rdfa` — each component is wrapped in a `<span>` with its class (and
  `itemprop`/`property` for schema.org), with values run through `Html::escape()`; the whole is a `FormattableMarkup`.
- `raw` — labelled "Raw, unescaped text" / "not recommended"; components are emitted without escaping.

Additional components: `parseAdditionalComponents()` reads `preferred_field_reference` / `alternative_field_reference`
(formatter setting, else field setting) and calls `displayname_get_additional_component()`, which resolves a
referenced entity label, a `_self` label, a `_self_property_*` value, or a rendered field (stripped of tags and
entity-decoded) with an `access('view')` gate.

## Templates & theme

`display_name_item`, `display_name_item_list`, and the FAPI `display_name` theme hooks are registered in
`displayname_theme()`; preprocessors live in `displayname.theme.inc` (list handling produces "et al." truncation for
long multi-value lists). `_displayname_value_sanitize()` offers `default` (Html::escape), `plain` (strip_tags), and
`raw` (no processing) helpers.
