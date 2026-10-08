<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Widget: bootstrap_layout_classes_widget

`src/Plugin/Field/FieldWidget/BootstrapLayoutClassesWidget.php`, extends `WidgetBase`.
`@FieldWidget(id = "bootstrap_layout_classes_widget", field_types = {"string","text"})`.
Select it on a plain-text field's **form display**. Attaches library
`bootstrap_layout_classes/form_style`.

## Widget settings (`defaultSettings()` + `settingsForm()`)

Schema: `field.widget.settings.bootstrap_layout_classes_widget` in
`config/schema/bootstrap_layout_classes.schema.yml`.

- `usage` (int, default `2`) — which element the classes are for: `0` Container, `1` Row,
  `2` Column. Affects only the Vertical/Horizontal labels on align/justify selects.
- `wrapper` (int, default `0`) — render the widget container as `0` Fieldset or `1` Details.
- Per-group **boolean** toggles deciding which controls appear (defaults in parens):
  `container` (F), `col` (T), `offset` (F), `order` (F), `margin` (T), `padding` (T),
  `gutter` (T), `align-items` (F), `align-self` (F), `justify-content` (F), `custom` (F).

`settingsSummary()` prints the usage, wrapper and the list of enabled class groups.

Note: a group also shows up if the current stored value already contains that class
(`hasAny()` check), even when its toggle is off — so existing data is never hidden.

## Form UI (`formElement()`)

Builds a `fieldset`/`details` wrapper (`class` `bootstrap_layout_classes_widget`) containing:

- A **layout table** with a "Standard" column plus one column per breakpoint
  (``, `-sm` ≥576, `-md` ≥768, `-lg` ≥992, `-xl` ≥1200, `-xxl` ≥1400). Rows shown per settings:
  Columns (`col`, width options 1–12 as %, `flex`, `auto`), Offset (1–12), Order
  (`first`, 1–12, `last`).
- **Outer** (`margin`) and **Inner** (`padding`) fieldsets with Top/Left/Right/Bottom selects,
  spacing options `0`–`5`, `auto`.
- **General** fieldset: `container` (`container` / `container-fluid`), `align-items`, `align-self`,
  `justify-content` (Auto/Start/Center/End), gutter `gx` (0–5/auto), and a **Custom Classes**
  `textfield` (`#size` 15) for free-text extra classes.

Existing values are re-parsed into these controls by `split()`.

## Value serialization (`massageFormValues()`)

Merges the nested table/margin/padding/general values over `defaultItems()` and produces one
space-separated string in `$value['value']`:

- Equal Top/Bottom margins fold into `my-*` (and clear `mt`/`mb`); equal Left/Right into `mx-*`;
  same for padding `py`/`px`.
- Duplicate consecutive per-breakpoint `col`/`offset`/`order` values are dropped (Bootstrap
  inherits up the breakpoints).
- `container` and `custom` are emitted verbatim; a `flex` selection emits the **bare** key
  (e.g. `col`, `col-md`); every other non-empty `key => val` emits `key-val` (e.g. `mt-3`).

## Parsing back (`split()`)

Splits the stored string on spaces; maps `mx`/`my`/`px`/`py` back to both sides, stores `container`
whole, records bare `col*` classes as `flex`, and any token it does not recognise goes into the
`custom` bucket (re-joined with spaces). So arbitrary classes typed in Custom Classes round-trip.

## Notes / caveats

- `validate()` (a hex-color check) and `$settingsOptions`/`$settingsOptionsUsage` static arrays
  exist; `validate()` is **not wired** into any element in this version (dead leftover — it also
  references `$this` from a static method, so it would fatal if ever called).
- Some option labels are hard-coded German/English mix (`order` `first` → `Erstes`); cosmetic only.
- Cardinality-1 plain-text field is assumed; the widget serializes each delta independently.
