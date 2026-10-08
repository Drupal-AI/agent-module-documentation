<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The donorperfect_donor entity and DonorController

## The entity (`src/Entity/Donor.php`)

`@ContentEntityType` id `donorperfect_donor`, `base_table = dp`, `udf_table = dpudf`,
`entity_keys { id = donor_id, label = name_full }`, `admin_permission = donorperfect admin`.
Handlers come from the base module — `Storage`, `StorageSchema`, `AccessControlHandler`, `ViewsData`
— plus `entity`'s `EntityPermissionProvider`, this module's `DonorViewBuilder`, and the
`DonorForm` add/edit form. Links: `/admin/donorperfect/donor/{id}` (canonical),
`/add`, `/{id}/edit`, `/list` (collection).

Records are **not** stored in Drupal: the base `Storage`/`Query` classes translate entity loads and
entity-query conditions into `DPQuery` calls against DonorPerfect. `Donor` extends the base
`EntityBase`, so most base fields are generated from the DonorPerfect `dp`/`dpudf` fields selected on
the settings form (types come from the `donorperfect.cache:dptables` metadata).

`Donor::baseFieldDefinitions()` adds two computed, read-only string fields (max length 512):

- **`name_full`** — `DonorNameFullFieldItemList::computeValue()` = trimmed `first_name . ' ' .
  last_name`. Used as the entity label.
- **`name_alpha`** — `DonorNameAlphaFieldItemList::computeValue()` = `last_name . ', ' . first_name`
  (falls back to whichever name exists). For alphabetical lists.

`DonorViewBuilder::build()` clears `content` (donor rendering is expected via Views/fields, not a
default full view). `DonorForm::save()` persists through the entity storage and messages/ redirects
to the donor's canonical page. **Delete is always forbidden** (base `AccessControlHandler`).

## DonorController (`src/Entity/DonorController.php`)

Service `donorperfect_donor.entity_controller`, injected with `config.factory`,
`donorperfect.dpquery`, `donorperfect.dputility`. Tagged `donorperfect.entity_controller`
priority 999. `ENTITY_TYPE_ID = 'donorperfect_donor'`; `getSettingsFormClass()` returns the donor
`SettingsForm`.

### `search(array $conditions, string $join_type = 'left'): array`

Builds a `select` DPQuery on `dp.donor_id` and returns matching donor ids (keyed by id). Each
condition may be `['table','field','value','wildcard'?,'operator'?]`, a `table.field => value` pair,
or an already-compiled SQL string (only accepted if it contains `= > < LIKE NULL`). Per-field
handling:

- **donor_id** — cast to `(int)`, supports arrays → OR of `dp.donor_id=N`.
- **first_name** — expands via `explodeFirstNames()` (splits on " and " and commas) and the
  configured `first_name_variations`; each name is added as a `LIKE '%name%'` condition. Names not
  matched to a variation group must pass `FormValidator::validateAlphaDash()`; single quotes are
  doubled.
- **email** — only added if `FormValidator::validateEmail()` passes; matches `dp.email` /
  `dpaddress.email`.
- **phone** (any `*phone*` field) — only if `FormValidator::validatePhone()` passes; normalized via
  `filterPhone()`; matches all four phone columns on `dp` and `dpaddress`.
- **address / city / state / zip** — only if `FormValidator::validateAlphaDash()` passes; `LIKE`.
- **other fields** — resolved against the cached `dptables`; varchar/char/text → `LIKE` (+ optional
  wildcard), else `=`; values pass `validateAlphaDash()` and are single-quote-escaped and quoted per
  the field's `quote` flag.

So caller-supplied search values are validated (alpha-dash / email / phone) and quote-escaped before
any DonorPerfect condition string is built. Results are ordered by `dp.last_name`, `dp.first_name`.

### `loadAddresses(array &$donors)`

For the given donor entities, runs one `select` on `dpaddress` (`dpaddress.donor_id IN (...)`) and
attaches, per donor, the extra `address_records`, formatted `addresses`, `emails` and `phones` onto
the entity's data bag (`EntityBase::setData()`), de-duplicated.

## Settings form (`src/Form/SettingsForm.php`)

Extends the base `EntitySettingsFormBase` with `ENTITY_TYPE_ID = donorperfect_donor`. Contributes a
"DonorPerfect Donor Entities → Entity Fields" checkbox set (from `dp` + `dpudf` fields) to the base
settings form; selections are saved under `donorperfect.settings:entity.donorperfect_donor.fields`
and rebuild the entity's base-field storage on submit.
