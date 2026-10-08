<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `EntityField` — the Commerce License type plugin

File: `src/Plugin/Commerce/LicenseType/EntityField.php`
Class: `Drupal\commerce_license_entity_field\Plugin\Commerce\LicenseType\EntityField`
Extends `LicenseTypeBase`; implements `ContainerFactoryPluginInterface`.

Plugin annotation: `@CommerceLicenseType(id = "entity_field", label = "Entity field value")`.

## Install / enable
```
composer require drupal/commerce_license_entity_field
drush en commerce_license_entity_field -y
```
Pulls in `commerce_license` and `dynamic_entity_reference`. No config to import, no settings route.
Use it by adding a **License** field to a product variation type (standard Commerce License setup)
and selecting the **Entity field value** license type, then configuring it per the form below.

## Injected services (`create()`)
- `entity_type.manager` — enumerate entity type definitions; load license storage in the hook.
- `entity_type.bundle.info` — build the entity-type/bundle option list on the config form.
- `entity_field.manager` — read the target bundle's field definitions in `revokeLicense()`.

## Configuration (`buildConfigurationForm` / `submitConfigurationForm`)
`defaultConfiguration()` keys: `target_entity_type_id`, `target_entity_bundle`, `entity_field_name`,
`entity_field_value` (all `''`), plus base license-type defaults.

Form fields (all `#required`):
- `target_entity_bundles` (**select**) — one option per fieldable, non-config entity type + bundle
  (value `"$entity_type_id:$bundle"`, natsorted). Its `#description` warns "Cart form is not yet
  implemented!". On submit it is `explode(':')`-split into `target_entity_type_id` /
  `target_entity_bundle`.
- `entity_field_name` (**textfield**) — the machine name of the field to set. (Free text: the
  intended field-*select* built from the bundle's field definitions is commented out in source.)
- `entity_field_value` (**textfield**) — the value to write.

Large commented-out blocks remain for: an AJAX-driven field selector, an "Entity restriction"
radios (`any` / `own` entities) that is **not** implemented, and `dsm()`/`ddl()` debug calls. Only
the three fields above are live. `validateConfigurationForm()` is empty.

## Mapping config onto the license (`setConfigurationValuesOnLicense`)
Because plugin config and license field names differ, it copies:
`license_target_field = configuration['entity_field_name']`,
`license_target_value = configuration['entity_field_value']`. The target **entity** itself is not
set here — it comes from the buyer's `license_target_entity` selection on the license.

## Bundle fields (`buildFieldDefinitions`)
Adds to the `commerce_license` entity: `license_target_entity` (`dynamic_entity_reference`, required),
`license_target_field` (`string`, required), `license_target_value` (`string`, required). Only
`license_target_entity` gets a view display; no form widget is configured (tied to the unfinished
cart form).

## Lifecycle (called by the Commerce License state machine)
- **`grantLicense(LicenseInterface $license)`** — runs on activation. Reads the target entity
  (`license_target_entity->entity`), the field name (`license_target_field->value`) and value
  (`license_target_value->value`), then `$target_entity->{$field} = $value; $target_entity->save();`.
- **`revokeLicense(LicenseInterface $license)`** — runs on expiry/cancel. Looks up the target
  field's definition via `entity_field.manager` and sets the field back to
  `$definition->getDefaultValue($target_entity)`, then saves. (Source TODO: it resets to the field
  **default**, not the value the field held before the grant.)
- **`buildLabel()`** — "Entity field license for {target entity label}".

## Delete guard (`commerce_license_entity_field_form_alter`, `.module`)
On any `EntityForm` for a saved entity where the current user has `delete` access, it queries for
**active** `entity_field` licenses whose `license_target_entity` points at this entity
(read-only `accessCheck(FALSE)` lookup). If any exist it sets `$form['actions']['delete']['#access']
= FALSE` and adds a status message naming the license, the locked field label, and (if set) the
expiry date — so the entity cannot be deleted while a paid license controls its field. Source TODOs
note this should also be enforced via `hook_entity_access()` at the API level (not yet done).

## Unfinished parts (per README + source)
- The **cart form** for the buyer to pick their target entity is not implemented; `license_target_entity`
  has no form widget wired up.
- The intended "own entities only" **restriction** and the field-name **select** are commented out.
- `grantLicense()`/`revokeLicense()` do not yet catch exceptions for a deleted/misconfigured field.

Treat this module as a starting point that requires custom code to complete before production use.
