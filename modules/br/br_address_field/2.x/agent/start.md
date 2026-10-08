<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Brazilian Address Field (br_address_field) — agent index

Structured **Brazilian postal-address field** with optional CEP (postal-code) auto-fill via the
ViaCEP web service. Core `^8 || ^9 || ^10 || ^11`. Package `7Links`. License GPL-2.0-or-later.

## Dependencies
- Composer requires `drupal/mask` `^2.0@alpha` (Mask module, for input masking). No hard
  `dependencies:` are declared in the `.info.yml`. No configuration route; no permissions;
  no config/schema, install, services or routing YAML files ship.

## What it provides
- **Field type** `br_address_field_type` — `BrAddressFieldType` (`src/Plugin/Field/FieldType/`).
  Single field, seven varchar columns: `postal_code` (CEP, 10), `thoroughfare` (255),
  `number` (10), `street_complement` (255, nullable), `neighborhood` (255), `city` (255),
  `state` (UF, 2). Default widget `br_address_widget_type`, default formatter
  `br_address_plain_formatter`.
- **Widget** `br_address_widget_type` — `BrAddressWidgetType` (`src/Plugin/Field/FieldWidget/`).
  One textfield per part + 27-option `state` select. Settings: `consult_postal_code` (CEP
  auto-fill on/off), `show_address_container` (details vs div), and per-part `required_*` flags.
  CEP auto-fill uses an `#ajax` change callback `ajaxConsultZip()` → `consultZip()` (ViaCEP).
- **Formatters** (`src/Plugin/Field/FieldFormatter/`): `br_address_plain_formatter`
  (whole address via theme + Twig; `display_state` = initials|full name), plus single-part
  `br_address_postal_code_formatter`, `br_address_thoroughfare_formatter`,
  `br_address_number_formatter`, `br_address_complement_formatter`,
  `br_address_neighborhood_formatter`, `br_address_city_formatter`,
  `br_address_state_formatter` (initials), `br_address_state_full_formatter` (full name).
- **Theme hook** `br_address_field` + `templates/br-address-field.html.twig`; CSS library
  `br_address_field/theme` (`css/br_address_field.css`). `hook_help` on `help.page.br_address_field`.

## Operate it
Enable the module, then use the normal field UI (Manage fields → add "Brazilian address";
Manage form display for widget settings; Manage display for the formatters). No dedicated
admin page.

## Solution docs
- [Field type, widget & CEP auto-fill](fields/field-and-widget.md)
- [Display formatters & Twig template](fields/formatters.md)
