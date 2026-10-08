<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Change labels (change_labels) — agent index

Overrides labels and button texts on Drupal **entity forms**, stored as **third-party settings** on
field widgets ("Manage form display") and on the entity form display. Display-only: no routes, no
permissions, no plugins, no entities, no data/schema changes. Package `Fields`. Core `^11.2`.
License GPL-2.0-or-later. Version 1.4.1.

- **All settings, where each is stored, config schema, and how to operate it** →
  [config/settings.md](config/settings.md)

## What it actually is

- No routing, no `*.permissions.yml`, no controllers, no plugins, no entities. All configuration is
  done through **core's** "Manage form display" and "Manage form display → settings gear" UIs, gated
  by core permissions (`administer <entity type> form display`).
- Implements only alter/settings hooks via **OOP `#[Hook]` attribute classes** in `src/Hook/`.
  `change_labels.services.yml` sets `change_labels.skip_procedural_hook_scan: true` (no `.module`
  file). Two settings-form hooks are merged into one because core does not yet allow multiple
  implementations of the same hook per module (see `ChangeAddAnotherLabel::addSettings`).
- `composer.json` still requires `drupal/hook_event_dispatcher: ^3 || ^4`, but per README it is **not
  used since 1.4.0** (core hook classes replaced it); kept only to prevent the module vanishing on an
  un-uninstalled update. `change_labels.info.yml` declares **no** `dependencies`.

## Hook classes (`src/Hook/`)

- `ChangeAddAnotherLabel` (class, `implements TrustedCallbackInterface`) — the entry point. Composes
  traits `ChangeFieldLabel`, `ChangeNumberField`, `ChangeRemoveLabel`. Adds widget third-party
  settings (`field_widget_third_party_settings_form`) and alters the built widget
  (`field_widget_complete_form_alter`): `add_another` (button `#value`), `hide_add_another`
  (`add_more #access = FALSE`), `force_single_cardinality` (sets `#cardinality = 1`, hides `_weight`).
- `ChangeFieldLabel` (trait) — `field_label_overwrite`: sets `#title` on the widget elements, or
  hides the label via `#title_display = invisible` (plus `#process`/`#pre_render` for details-wrapped
  widgets like file/address) when the value is the literal token `<nolabel>`.
- `ChangeNumberField` (trait) — only for core `NumberWidget`: `number_size` sets each value input's
  `#size`.
- `ChangeRemoveLabel` (trait) — only for core `FileWidget`: `remove_label` swaps the `remove_button`
  `#value` via a `#process` callback.
- `ChangeSubmitLabel` (class) — alters `entity_form_display_form` to add a "Change labels" fieldset
  (`submit_label`, `submit_message`) saved as third-party settings on the form-display entity via an
  `#entity_builders` callback; `form_alter` applies `submit_label` to the submit button and, if
  `submit_message` is set, appends `::replaceMessage` (clears status messages, adds the replacement).

## Config schema

- `config/schema/change_labels.field.schema.yml` — widget third-party settings
  (`field.widget.third_party.change_labels`): `add_another`, `remove_label`,
  `field_label_overwrite`, `hide_add_another`, `force_single_cardinality`.
- `config/schema/change_labels.schema.yml` — form-display third-party settings
  (`core.entity_form_display.*.*.*.third_party.change_labels`): `submit_label`. (`number_size` and
  `submit_message` are read/written by code but are not declared in schema — see config doc.)
