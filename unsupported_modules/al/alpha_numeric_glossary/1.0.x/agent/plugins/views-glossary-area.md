<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Glossary area handler — placement, wiring & options

Source: `src/Plugin/views/area/AlphaNumericGlossaryArea.php` (extends `AreaPluginBase`),
rendering via `src/AlphaNumericGlossary.php` + `src/AlphaNumericGlossaryCharacter.php`.

## Install / enable

`drush en alpha_numeric_glossary -y` (core `views` is the only dependency). Nothing else to
configure globally — there is no settings route and no `config/install`.

## How to wire it up on a View (the two required parts)

The area handler renders the navigation and marks which letters have content; a **contextual
filter** does the actual result filtering. Both are needed:

1. Build a View of nodes / users / taxonomy terms / comments / media.
2. Add the field you want to glossary against (title/body/name/a text field). You may set it
   *Exclude from display*.
3. Add a **contextual filter** on that same field, set **Glossary mode**, **character limit 1**,
   and **Transform case → Upper Case** (per `hook_help`). Give it a default (e.g. fixed value `a`)
   so the page has a current character.
4. Add **Global: Alpha Numeric Glossary** to the View's **Header or Footer** (id
   `alpha_numeric_glossary`). Configure it (below). There must be **exactly one** glossary area per
   display — `AlphaNumericGlossary::validate()` errors if there are zero or more than one.

The area's link path (default `[alpha_numeric_glossary:path]/[alpha_numeric_glossary:value]`)
produces URLs like `/my-view/a`; the contextual filter reads that trailing arg and filters.
`getCharacters()` reads `$view->args` to mark the current character **active**.

## Options (`defineOptions()` — all keys are `glossary_*`, stored in the handler options)

Grouping / behavior:
- `glossary_view_field` (default `title`) — the field the glossary groups on. The form lists the
  base `title`/`name` plus every `text`, `text_long`, `text_with_summary`, `string`, `string_long`
  field on the base entity type. Compound `name` fields expose `field:column` choices.
- `glossary_toggle_empty` (default 1) — show letters that have no results (as inactive spans). When
  off, empty characters are filtered out entirely.
- `glossary_display_count` (default 0) — append a per-character result count as `<sup>(n)</sup>`.
- `glossary_disable_first_char_active` (default 0) — a landing-page path (e.g. `/` or `/home`) on
  which the first character is **not** auto-activated.
- `glossary_case_text` (default `mb_strtoupper`) — case transform for displayed characters. Note:
  choosing `mb_strtolower` also switches the built-in default alphabet to lowercase a-z.
- `glossary_case_link` (default `mb_strtolower`) — case transform applied to the value in link URLs
  (via the `alpha_numeric_glossary:value` token; see `alpha_numeric_glossary_tokens()`).

Link (details fieldset):
- `glossary_link_path` (default `[alpha_numeric_glossary:path]/[alpha_numeric_glossary:value]`) —
  token path each character links to. No leading/trailing slash. A path beginning with `#` renders
  as an on-page anchor (auto-treated as external, empty href avoided by the group field).
- `glossary_link_external` (default 0) — treat the path as an external/unprocessed link.
- `glossary_link_class` (default '') — space-separated CSS classes on each link
  (sanitized via `Html::cleanCssIdentifier`).
- `glossary_link_attributes` (default '') — extra attributes as `key|value,key|value`
  (token-replaced). **Sanitized with `Xss::filterAdmin()` in `submitOptionsForm()`**; any `class`
  key is stripped (use `glossary_link_class`).

Wrapper / item classes: `glossary_class` (`alpha-numeric-glossary`), `glossary_list_class`
(`alpha-numeric-glossary-list`), `glossary_active_class` (`active`), `glossary_inactive_class`
(`inactive`). All run through `Html::cleanCssIdentifier`.

"All" item: `glossary_all_display` (1), `glossary_all_class` (`all`), `glossary_all_label`
(`All`), `glossary_all_value` (`all`), `glossary_all_position` (`after`). When on, an "All" link is
prepended/appended; it is always treated as enabled/linked.

Numeric items: `glossary_view_numbers` (0=none, 1=individual 0-9, 2=single `#` label),
`glossary_numeric_class` (`numeric`), `glossary_numeric_divider` (1) +
`glossary_numeric_divider_class` (`-`) — a divider item between numbers and letters (mode 1 only),
`glossary_numeric_hide_empty` (1) — drop all numeric items if none match,
`glossary_numeric_label` (`#`), `glossary_numeric_position` (`before`),
`glossary_numeric_value` (default = `0+1+...+9`) — the URL value representing "all digits" in mode 2.

## Rendering (`render()`)

Iterates `AlphaNumericGlossary::getCharacters()`; for each `AlphaNumericGlossaryCharacter` calls
`build()` → a `#type => link` when the character `isLink()` (enabled/all and not the active one),
else a `#type => html_tag` `<span>`. Wrapper classes (`all` / `numeric` / active / inactive) are
added per item; the whole thing is a `#theme => item_list__alpha_numeric_glossary` inside a
`container__alpha_numeric_glossary__wrapper`, attaching the module's CSS library. There is no
Twig template shipped — theme via those suggestions / the CSS classes.

## Notes

- Base-table specifics: for `taxonomy_term_data` / `media_field_data` the field list offers `name`;
  otherwise `title`. The `name`/`title` cases read the entity's base-field schema column.
- Multilingual: `getCharacters()`/`getAlphabet()` are per-langcode; alphabets are cached under cid
  `alpha_numeric_glossary:alphabets`. Content edits invalidate `alpha_numeric_glossary:<entity_type>`
  cache tags (`alpha_numeric_glossary_entity_presave`).
