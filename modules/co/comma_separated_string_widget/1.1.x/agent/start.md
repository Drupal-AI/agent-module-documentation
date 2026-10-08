<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Comma Separated String Widget (comma_separated_string_widget) — agent index

A single-plugin field widget: it lets an editor fill a **multi-value `string` field** from **one
text box** of comma-separated values instead of one row per value. On save the widget splits the
input on commas into the field's separate values; on edit it joins the stored values back into one
comma-separated string. Version **1.1.3** (version dir `1.1.x`). Core `^9 || ^10 || ^11`. License
GPL-2.0-or-later. No dependencies, no config page, no permissions, no services, no JS.

## What it provides (from source)

The whole module is one class: `src/Plugin/Field/FieldWidget/CommaSeparatedStringWidget.php`,
extending core `StringTextfieldWidget`.

- **Widget plugin** id `comma_separated_string_textfield`, label **"Textfield (comma separated
  values)"**, `field_types = {"string"}`, and crucially `multiple_values = TRUE` — so core hands the
  whole multi-value item list to one widget instance (a single textfield) rather than one widget per
  delta.
- **`formElement()`** — calls `parent::formElement()`, then if the item list is non-empty maps the
  items to their `->value`, drops empties with `array_filter()`, and sets
  `$element['value']['#default_value'] = implode(', ', $values)` (comma-space join). Empty list → the
  parent element is returned untouched.
- **`massageFormValues()`** — runs the parent massage, then returns `static::massageInput($values['value'] ?? '')`,
  turning the one submitted string into the multi-value array core expects.
- **`massageInput(string $input, string $delimiter = ',')`** (public static) — `explode` on the
  delimiter, `trim` each item, `array_filter` (drops empty strings), re-index, and wrap each as
  `['value' => $item]`. Effects: surrounding whitespace is stripped, empty segments are dropped, but
  **duplicates are kept** (`a,,a` → two `a` values). Empty input → `[]`. The delimiter is
  hard-coded to `,` in all call paths — there is no widget setting to change it.

No `.install`, no `.module`, no `config/`, no `*.libraries.yml`, no templates, no `composer.json`.
Values are stored as plain strings and rendered through core's standard `string` field formatter
(HTML-escaped by core). PHPUnit unit test at
`tests/src/Unit/Plugin/Field/FieldWidget/CommaSeparatedStringWidgetTest.php` covers the three
methods.

## Usage

Set a multi-value `string` field's **Manage form display** widget to "Textfield (comma separated
values)". No further configuration. See [../usage.md](../usage.md) and
[../human-docs/index.md](../human-docs/index.md).
