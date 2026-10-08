<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Install, settings, the order field & the orders view

## Install & enable

```bash
composer require drupal/crm_core_commerce
drush en crm_core_commerce -y
```

Pulls in and requires **CRM Core** (`crm_core`, `crm_core_contact`, `crm_core_user_sync`) and
**Commerce** (`commerce_order`). Composer constraints: `drupal/commerce ^2 || ^3`,
`drupal/crm_core ~3.0 || 3.x-dev`.

Enabling runs `hook_entity_base_field_info()` which adds the `crm_core_individual` entity-reference
base field to `commerce_order`, and installs the `crm_core_individual_orders` view from
`config/install/`. Existing sites upgrading from an older schema run
`crm_core_commerce_update_8702()`, which installs the field storage and copies data from the
legacy `field_individual_ref` field before uninstalling it.

## Prerequisite: an email primary field on the Individual type

Per the README, the target CRM Core Individual type must have an **email** field designated as a
primary field — it is the unique identity used to match anonymous customers (see
[../api/mapper.md](../api/mapper.md)). The 3.x line historically needed a crm_core patch
(drupal.org issue 3043132) for the primary-field API; verify your crm_core version exposes
`getPrimaryFields()` on `crm_core_individual_type`.

## The settings form

Route `crm_core_commerce.settings` → **`/admin/config/crm-core/commerce/settings`**, title
*"Commerce settings"*, permission **`administer crm-core`** (defined by crm_core). Menu link sits
under *Configuration → CRM Core* (`crm_core.config_overview`).

`SettingsForm` (`src/Form/SettingsForm.php`, form id `crm_core_commerce_settings_form`, extends
`ConfigFormBase`) shows one select — **Order Individual Type** — populated from every
`crm_core_individual_type` entity (`loadMultiple()`), and saves the chosen bundle id to
`crm_core_commerce.settings:individual_type`.

## Config object & schema

Config object **`crm_core_commerce.settings`**, schema `config/schema/crm_core_commerce.schema.yml`:

| Key | Type | Meaning |
|---|---|---|
| `individual_type` | string | Machine id of the `crm_core_individual_type` bundle that orders map to. |

Config-export example:

```yaml
# crm_core_commerce.settings.yml
individual_type: contact
```

> If `individual_type` is `NULL` (never saved), `CrmCoreIndividualMapper::getIndividualType()`
> throws `Drupal\Core\Config\StorageException` — so set it before any order reaches the *place*
> transition, otherwise checkout errors.

## The order → individual reference field

`crm_core_individual` on `commerce_order`: `entity_reference`, cardinality 1, target
`crm_core_individual`, form widget `entity_reference_autocomplete`, view display
`entity_reference_label` — both display-configurable. `OrderPlacedSubscriber` writes the resolved
Individual back onto this field when an order is placed, and the field is also a lookup path in
the mapper (an order that already references an Individual reuses it).

## The bundled orders view

`crm_core_individual_orders` (base table `commerce_order`) — a table view with a `default` display
and a `block` display, argument = the `crm_core_individual` field. Columns: order number, total
price, total paid, state, order items (+ operations). `hook_preprocess_crm_core_individual()` in
the `.module` embeds the `block` display on the Individual's **full** view mode under an
*"This Individuals Orders"* heading (weight 100), passing the individual id as the contextual
argument. The default display's access plugin is `none`, but it is only rendered inside the
individual's already access-controlled full view.
