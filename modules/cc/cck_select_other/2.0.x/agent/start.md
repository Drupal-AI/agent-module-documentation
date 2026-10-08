<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Select Other (cck_select_other) — agent index

Form **widget** for core **List fields** (`list_string`, `list_integer`, `list_float`; **not**
`list_boolean`) that renders the field's configured allowed values as a select list plus an
**"Other"** choice which reveals a text input for an off-list value. The typed value is stored
directly into the same list field. Depends only on core `options`. A direct port of the Drupal
6/7 **CCK** "select or other" widget (the `cck_` prefix). Version **2.0.0-alpha3** — alpha.
Core requirement **`^11.3 || ^12`** — Drupal 11.3+ only, reaching into a not-yet-released major.

## What it provides
- **Field widget** `cck_select_other` (`SelectOtherWidget`, extends `OptionsWidgetBase`). One
  setting: `other_label` (default "Other"). Renders a `select` (options + `other` + optional
  `_none`/`- Select a value -`) and a `select_other_text_input` textfield; `js/widget.js`
  (`cck_select_other/widget` library, jQuery) toggles the textfield visibility.
- **Field formatter** `cck_select_other` (`SelectOtherFormatter`). Looks the stored value up in
  `allowed_values`; if absent (an "other" value) it renders the raw stored value. Both paths go
  through `FieldFilteredMarkup::create()`.
- **Views filter** `select_other` (`SelectOtherFilter`, extends core `options` `ListField`).
  `hook_views_data_alter` (`CckSelectOtherViewsHooks`) swaps the filter id to `select_other` for
  any field whose form display uses this widget; adds the "Other" bucket to exposed filters.
- **Config schema**: `field.widget.settings.cck_select_other` (just `other_label`).

## Core mechanism — how "other" passes validation (read this)
Drupal decouples fields from widgets, so a widget cannot loosen a field's allowed-values check.
The module works around it by **replacing core's `AllowedValues` validation constraint plugin
site-wide**: `CckSelectOtherHooks::validationConstraintAlter()` (`hook_validation_constraint_alter`)
rewrites the `AllowedValues` definition's `class` to
`SelectOtherAllowedValuesConstraint` and `provider` to `cck_select_other`. The paired
`SelectOtherAllowedValuesConstraintValidator`:
- For a `ListItemBase` field that **has this widget on some entity form display**
  (`EntityDisplayTrait::hasSelectOtherWidget()`), it adds the submitted value to the allowed
  choices → **any value passes** (verified: the live site reports the AllowedValues constraint
  class is the module's).
- For all other List fields it falls back (`validateFallback`) to core behavior
  (`getSettableValues`), so their validation is unchanged.
- Entity-reference fields return early (core already strips their AllowedValues constraint).

The widget's own `validateElement()` adds form-level checks: a required-but-empty select errors;
"other" with an empty box errors (required) or stores NULL (optional); a tampered select value
not in `#options` errors ("not a valid choice"); otherwise the select value or the "other" text
is stored.

## Consequences to design around
1. **A field with this widget is no longer a closed set on ANY write path** (form *and*
   REST/JSON:API/migration/programmatic), because the bypass lives at the field-constraint level,
   not in the widget. Facets, Views filters, and code treating the key as a known machine value
   must tolerate off-list values. Want the list to stay authoritative? Store the free text in a
   **second** field. This is intentional, documented behavior (README).
2. **"Other" is free user text on display.** The module's formatter escapes via
   `FieldFilteredMarkup` + core render filtering; a custom render path must escape it too.
3. **Numeric list types are risky for free text** — arbitrary strings into `list_integer` /
   `list_float` are a storage/robustness hazard. Prefer `list_string` for "other".

## Files
- `src/Plugin/Field/FieldWidget/SelectOtherWidget.php` — the widget.
- `src/Plugin/Field/FieldFormatter/SelectOtherFormatter.php` — the formatter.
- `src/Plugin/views/filter/SelectOtherFilter.php` — the Views filter.
- `src/Hook/CckSelectOtherHooks.php` — constraint override.
- `src/Hook/CckSelectOtherViewsHooks.php` — Views data alter.
- `src/Validation/Plugin/Validation/Constraint/*` — constraint + validator.
- `src/EntityDisplayTrait.php` — detects the widget / reads its settings from form displays.
- `js/widget.js` — toggles the "other" textfield.

## See also
- `agent/fields/select-other-widget.md` — configure the widget, formatter, filter, and the
  allowed-values behavior in detail.
