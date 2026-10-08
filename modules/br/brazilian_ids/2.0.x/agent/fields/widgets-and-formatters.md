<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field widgets, the RG field type, and formatters

All of this is wired through the standard Field UI (Manage fields / Manage form display / Manage
display). No module-specific routes or permissions.

## Widgets on the core `string` field (`src/Plugin/Field/FieldWidget/`)

Add a normal **Text (plain), string** field, then on *Manage form display* pick one of:

- `brazilian_ids_cpf` — `CpfWidget`, label "CPF", default `size = 14`.
- `brazilian_ids_cnpj` — `CnpjWidget`, label "CNPJ".
- `brazilian_ids_cpf_cnpj` — `CpfCnpjWidget`, label "CPF or CNPJ", default `size = 18`.

Each extends core `StringTextfieldWidget`. `formElement()` replaces the value element with the matching
render element (`#type => brazilian_ids_cpf|cnpj|cpf_cnpj`), passing `#size`, `#placeholder` and the
core `js-text-full`/`text-full` classes. Validation and cleaning therefore come from the render element
+ service (see [../api/service-and-elements.md](../api/service-and-elements.md)) — the stored `value`
is digits-only (11 for CPF, 14 for CNPJ). Settings are the inherited string-widget settings (size,
placeholder).

## RG field type `brazilian_ids_rg` (`src/Plugin/Field/FieldType/RgItem.php`)

A dedicated field type (not the core string field). `@FieldType(id="brazilian_ids_rg", label="RG",
default_widget="brazilian_ids_rg_default", default_formatter="brazilian_ids_rg_default")`.

- **Storage columns** (`schema()`): `number` varchar(20); plus `agency` varchar(60) and `state`
  varchar(2) unless the storage setting `number_only` is TRUE.
- **Properties** (`propertyDefinitions()`): `number`, `agency`, `state` (all string).
- **Storage setting** `number_only` (default FALSE) — set on the field's *storage settings* form
  (`storageSettingsForm()`); a checkbox, `#disabled` once data exists (cannot change after storage).
- `isEmpty()` is TRUE when `number` is empty.
- Config schema for the storage setting: `field.storage_settings.brazilian_ids_rg` in
  `config/schema/brazilian_ids.schema.yml`.

### RG widget `brazilian_ids_rg_default` (`RgDefaultWidget`)

Extends `WidgetBase`. `formElement()` emits a `brazilian_ids_rg` render element, wiring
`#number_only` from the field's `number_only` storage setting and `#clean_number` from the widget
setting. Widget setting `clean_number` (default FALSE, schema
`field.widget.settings.brazilian_ids_rg_default`): when on, strips dots/hyphens/slashes from the number
on submission. `settingsSummary()` reports "Clean number: Yes/No".

## Formatters (`src/Plugin/Field/FieldFormatter/`)

For the **core `string` field** (choose on *Manage display*):

- `brazilian_ids_cpf` (`CpfFormatter`), `brazilian_ids_cnpj` (`CnpjFormatter`), `brazilian_ids_cpf_cnpj`
  (`CpfCnpjFormatter`) — each extends core `StringFormatter`, injects the `brazilian_ids` service, and
  in `viewValue()` sets the render array's `#context['value']` to the service-formatted string
  (`000.000.000-00` / `00.000.000/0000-00`). Output goes through core's string-formatter template, so
  the value is escaped on render.

For the **`brazilian_ids_rg` field**:

- `brazilian_ids_rg_default` (`RgDefaultFormatter`) — renders `number`, then `/ Issuing ag.: <agency>`
  and `- <state>` when present.
- `brazilian_ids_rg_number` (`RgNumberFormatter`) — number only.
- `brazilian_ids_rg_agency` (`RgAgencyFormatter`) — agency only.
- `brazilian_ids_rg_state` (`RgStateFormatter`) — state only.

All four RG formatters build `#plain_text` render arrays (values are escaped as plain text).

## Optional masking

Enabling `drupal/mask` turns on live input masks for the CPF/CNPJ widgets/elements (see the elements
doc). Nothing else about the field/formatter behaviour changes.
