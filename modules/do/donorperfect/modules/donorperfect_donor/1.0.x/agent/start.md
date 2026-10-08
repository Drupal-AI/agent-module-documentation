<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DonorPerfect Donor (donorperfect_donor) — agent index

Submodule of **donorperfect**. Defines the `donorperfect_donor` content entity (DonorPerfect donor
record) and the donor **search** used by the base Name form element. Package `DonorPerfect`.
Core `^10 || ^11`, PHP `^8.0`. GPL-2.0-or-later. Version 1.0.x (installed 1.0.20).

Depends on `donorperfect:donorperfect` (the base module) only.

- **The entity, its tables/fields, the DonorController search + address loading** →
  [entity/donor.md](entity/donor.md)

## What it provides (from source)

- **Entity** `donorperfect_donor` (`src/Entity/Donor.php`, `@ContentEntityType`): base table `dp`,
  `udf_table` `dpudf`, id key `donor_id`, label key `name_full`. Handlers: base module's `Storage`,
  `StorageSchema`, `AccessControlHandler`, `ViewsData`; `entity` module's `EntityPermissionProvider`;
  own `DonorViewBuilder`; add/edit form `DonorForm`. `admin_permission = donorperfect admin`.
  Routes: canonical/add/edit/collection under `/admin/donorperfect/donor`.
- **Computed base fields** (`Donor::baseFieldDefinitions()`): `name_full` (First Last) via
  `DonorNameFullFieldItemList`; `name_alpha` (Last, First) via `DonorNameAlphaFieldItemList`. All
  other base fields are built by the base `EntityBase` from the selected `dp`/`dpudf` cached fields.
- **Service** `donorperfect_donor.entity_controller` → `Entity\DonorController` (args
  `config.factory`, `donorperfect.dpquery`, `donorperfect.dputility`), tagged
  `donorperfect.entity_controller` **priority 999** (highest). Methods: `search()`, `loadAddresses()`,
  `addWildcard()`, `explodeFirstNames()`, `getSettingsFormClass()`.
- **Settings form** `Form\SettingsForm` (extends base `EntitySettingsFormBase`), contributing the
  donor "Entity Fields" checkboxes to the base settings form.
- **Forms** `Form\DonorForm` (extends `ContentEntityForm`); add/edit save via the entity storage
  (which writes back to DonorPerfect through DPQuery). Delete is forbidden by the base access handler.

No routing.yml, permissions.yml (entity permissions come from `EntityPermissionProvider`), config
schema or Drush of its own.
