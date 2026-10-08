<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field type, widget & CEP auto-fill

## Field type — `BrAddressFieldType`
`src/Plugin/Field/FieldType/BrAddressFieldType.php`, id `br_address_field_type`, label
"Brazilian address". Single-cardinality structured field. `default_widget = br_address_widget_type`,
`default_formatter = br_address_plain_formatter`.

`propertyDefinitions()` / `schema()` define seven string properties + columns:

| Property | Column type | Length | Notes |
|---|---|---|---|
| `postal_code` | varchar | 10 | CEP |
| `thoroughfare` | varchar | 255 | logradouro |
| `number` | varchar | 10 | |
| `street_complement` | varchar | 255 | `not null` FALSE (nullable) |
| `neighborhood` | varchar | 255 | bairro |
| `city` | varchar | 255 | |
| `state` | varchar | 2 | UF initials |

All properties are `setRequired(FALSE)` at the property level (required-ness is enforced by the
widget, not the storage). `defaultStorageSettings()` sets `max_length 255`, `is_ascii FALSE`,
`case_sensitive FALSE`. `getConstraints()` adds nothing beyond the parent. `isEmpty()` returns
true only when `postal_code`, `thoroughfare`, `city` **and** `state` are all empty (number,
complement and neighborhood do not count toward emptiness).

## Widget — `BrAddressWidgetType`
`src/Plugin/Field/FieldWidget/BrAddressWidgetType.php`, id `br_address_widget_type`.

**Settings** (`defaultSettings()` / `settingsForm()` / `settingsSummary()`), stored in the form
display config (no dedicated `config/schema` ships):

- `consult_postal_code` (default 1) — "Fill address": enables CEP auto-fill.
- `show_address_container` (default 1) — render inputs inside an open `details` element
  (`#type => details`, `id=address-container`) when on, else a `div` html_tag.
- `required_postal_code` / `required_thoroughfare` / `required_number` /
  `required_street_complement` (default 0) / `required_neighborhood` / `required_city` /
  `required_state` — per-part required flags (all default 1 except complement).

**`formElement()`** builds a `textfield` per part plus a `state` `select` whose `#options` are the
27 Brazilian UFs (`AC` Acre … `TO` Tocantins), defaulting to `AC`. Required flags are additionally
gated on `!in_array('default_value_input', $form['#parents'])` (they do not apply on the field's
default-value form). Attaches library `br_address_field/theme`. When `consult_postal_code` is on,
the `postal_code` textfield gets an `#ajax` callback firing on `change`, wrapper `address-container`,
throbber "Verifying entry...".

## CEP auto-fill flow
1. `ajaxConsultZip(&$form, $form_state)` — the `#ajax` callback. It reads the triggering element's
   `#array_parents`, reconstructs the submitted postal code from `$form_state->getValues()` via the
   private `createArray()` helper + `NestedArray::getValue()`, then sanitizes it:
   `preg_replace('/[^0-9\-]/', '', $postal_code)` (digits and hyphen only).
2. `consultZip($zip)` — performs the lookup with a Guzzle `Client`:
   `GET http://viacep.com.br/ws/{$zip}/json/` with `Accept: application/json`, `json_decode`s the
   body and returns the decoded object. The host is fixed (`viacep.com.br`); only the sanitized CEP
   is interpolated into the path.
3. On success (no `->erro`), the callback returns an `AjaxResponse` of `InvokeCommand` `val`
   operations that write `cep`, `logradouro`, `bairro`, `localidade` and `uf` from the ViaCEP
   response into the corresponding form inputs (clearing `number` and `street_complement`) and
   triggers `change` on the state select. On failure it shows a "Postal code not found." error
   message and clears the fields.

There is **no** module-defined route, controller, or permission — the lookup runs only inside the
standard Field API widget AJAX flow of the entity/field edit form, so it is reachable exactly by
users who can already render and submit that form.

## Install / operate
1. `drush en br_address_field` (Composer pulls `drupal/mask`).
2. Manage fields on a bundle → add field "Brazilian address".
3. Manage form display → pick the "Brazilian address" widget and set its options (CEP auto-fill,
   container, required parts).
4. Manage display → choose a formatter (see `formatters.md`).
