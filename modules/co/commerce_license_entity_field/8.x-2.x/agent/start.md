<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce License Entity Field (commerce_license_entity_field) — agent index

Provides a single **Commerce License type** (`entity_field`) that, while the license is
active, writes an admin-configured value onto a configured **field of a target entity** the
buyer selects. Models "upgrade" purchases as a field change rather than a role — e.g. paying
to flip a node's `promoted` flag. Version **8.x-2.0-alpha7** (`8.x-2.x`).

## Facts
- **Type:** module. `core_version_requirement: ^10.1 || ^11`. Package `Commerce (contrib)`.
- **Dependencies:** `commerce_license:commerce_license`, `dynamic_entity_reference:dynamic_entity_reference`.
- **No** routes, permissions, services, admin settings form, Drush, submodules, config/ dir,
  templates, JS, or `.install`. Everything is the license-type plugin plus one hook.
- **Provides one plugin instance** (not a new plugin type): `EntityField` — a
  `@CommerceLicenseType` (id `entity_field`, label "Entity field value").
- **Module file:** `commerce_license_entity_field_form_alter()` — on the edit form of an entity
  whose field is controlled by an **active** `entity_field` license, hides the **delete** action
  and shows a status message (prevents leaving a paid license in an illogical state).
- **Status:** README declares the module **INCOMPLETE** — the buyer-facing cart-form entity
  selection widget is not finished; large blocks of the config form are commented out.

## How it works (one line)
The product's license config stores a target field name + value on the license
(`setConfigurationValuesOnLicense` → `license_target_field` / `license_target_value`); the buyer's
chosen target entity is stored on `license_target_entity`; `grantLicense()` sets the value on that
entity's field and saves it; `revokeLicense()` resets the field to its **default value** and saves.

## Bundle fields added to `commerce_license` (`buildFieldDefinitions`)
- `license_target_entity` — `dynamic_entity_reference` (cardinality 1, required): the entity the
  license sets a value on. Any entity type may be referenced.
- `license_target_field` — `string` (required): the machine name of the field to set.
- `license_target_value` — `string` (required): the value to set. (TODO in source: wants `map`
  for large serialized values but that crashes core; see drupal.org/node/2887105.)

## Solution docs
- [`EntityField` license type plugin](plugins/entity_field_license_type.md) — the class, injected
  services, config form, grant/revoke lifecycle, the delete-guard hook, and the unfinished parts.

## Security posture (public)
Configuration of *which field* and *what value* to grant is set by the store/product administrator,
not the buyer. The module defines no routes, permissions, or callbacks; the only license lookup
(in `form_alter`) is a read-only `accessCheck(FALSE)` query used solely to detect a controlling
license before removing the delete action, and it first checks the user's own `delete` access.
Grant/revoke run inside the Commerce License state machine.
