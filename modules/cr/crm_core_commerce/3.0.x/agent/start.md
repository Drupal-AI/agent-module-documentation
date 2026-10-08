<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CRM Core Commerce (crm_core_commerce) — agent index

Glue module that creates/updates a **CRM Core Individual** from a **Drupal Commerce** order when
the order is placed. Package `CRM Core`. Core `^9 || ^10 || ^11`. License GPL-2.0-or-later.
Version 3.0.2 (dir `3.0.x`).

**Dependencies** (all required): `crm_core:crm_core`, `crm_core:crm_core_contact`,
`crm_core:crm_core_user_sync`, `commerce:commerce_order`. Composer also pulls `drupal/commerce`
(`^2 || ^3`) and `drupal/crm_core` (`~3.0 || 3.x-dev`).

- **The mapper service, the order→individual matching/mapping logic, the alter hook, extending the
  mapper** → [api/mapper.md](api/mapper.md)
- **Enable, the settings form/config object, the added order field, the bundled view** →
  [config/settings.md](config/settings.md)

## What it actually provides (from source)

- **Event subscriber** `OrderPlacedSubscriber` (`src/EventSubscriber/OrderPlacedSubscriber.php`,
  service `crm_core_commerce.order_paid_subscriber`) — subscribes to **`commerce_order.place.pre_transition`**
  (note: README/project page say *post*_transition; the code uses **pre**_transition). Method
  `saveCrmIndividual()` calls the mapper, `validate()`s the Individual, `save()`s it, and sets
  it back on the order's `crm_core_individual` field.
- **Mapper service** `crm_core_commerce.individual_mapper` →
  `Drupal\crm_core_commerce\Mapper\CrmCoreIndividualMapper` (implements
  `CrmCoreIndividualMapperInterface::mapOrderToIndividual(OrderInterface): IndividualInterface`).
  Args: `@entity_type.manager`, `@crm_core_user_sync.relation`, `@config.factory`,
  `@module_handler`.
- **Base field** `crm_core_individual` on `commerce_order` — an entity_reference (cardinality 1)
  to `crm_core_individual`, added via `hook_entity_base_field_info()` in the `.module`.
- **Settings form** `SettingsForm` (`src/Form/SettingsForm.php`) at route
  `crm_core_commerce.settings` → `/admin/config/crm-core/commerce/settings`, permission
  **`administer crm-core`** (defined by crm_core, not this module). Menu link under
  `crm_core.config_overview`.
- **Config object** `crm_core_commerce.settings` (schema in `config/schema/`) — single key
  `individual_type` (the target `crm_core_individual_type` bundle).
- **View** `crm_core_individual_orders` (`config/install/views.view.crm_core_individual_orders.yml`)
  — table of an individual's orders; embedded as a block on the individual's full view via
  `hook_preprocess_crm_core_individual()`.
- **Alter hook** `hook_crm_core_individual_data_alter(array &$data, OrderInterface $order)` —
  invoked in `getData()` before the Individual is written.
- **Update hook** `crm_core_commerce_update_8702()` (`.install`) — installs the
  `crm_core_individual` field storage and migrates legacy `field_individual_ref` data.

No permissions defined here, no Drush commands, no plugin types. Ships a Kernel test
(`tests/src/Kernel/MapperTest.php`).

## Setup in one line

Enable, ensure the CRM Core Individual type has an **email** primary field (used as the unique
identity for matching), then pick that type at `/admin/config/crm-core/commerce/settings`. If
`individual_type` is unset the mapper throws `StorageException` on the next order placement.
See [config/settings.md](config/settings.md).
