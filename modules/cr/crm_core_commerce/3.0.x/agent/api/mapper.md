<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The order → individual mapper & the alter hook

## Trigger

`OrderPlacedSubscriber` (`src/EventSubscriber/OrderPlacedSubscriber.php`, service
`crm_core_commerce.order_paid_subscriber`) subscribes to **`commerce_order.place.pre_transition`**
(a state_machine `WorkflowTransitionEvent`). Method `saveCrmIndividual($event)`:

1. `$order = $event->getEntity()`
2. `$individual = $this->crmIndividualMapper->mapOrderToIndividual($order)`
3. `if (!$individual->validate()) throw new EntityMalformedException($individual);`
4. `$individual->save()`
5. `$order->set('crm_core_individual', $individual)`

Because it runs on **pre**_transition, a malformed Individual (failing `validate()`) throws and
aborts the placement. (The README/project text say *post*_transition — the shipped code uses
pre_transition.)

## Service `crm_core_commerce.individual_mapper`

`Drupal\crm_core_commerce\Mapper\CrmCoreIndividualMapper` implements
`CrmCoreIndividualMapperInterface` (single public method
`mapOrderToIndividual(OrderInterface $order): IndividualInterface`).
Constructor args: `@entity_type.manager`, `@crm_core_user_sync.relation`, `@config.factory`,
`@module_handler`.

### `getIndividualType(): string` (protected)

Reads `crm_core_commerce.settings:individual_type`. Throws `StorageException` if it is `NULL`.

### `getIndividual(OrderInterface $order): ?IndividualInterface` (protected) — matching order

Loads the configured `crm_core_individual_type` and its `getPrimaryFields()`, then tries, **in
this order**, to find an existing Individual:

1. **By linked user account** — if `$order->getCustomerId() > 0`, ask
   `crm_core_user_sync.relation` (`getIndividualIdFromUserId()`) for the Individual linked to that
   user; load and return it if found.
2. **By the order's own reference** — if `$order->get('crm_core_individual')->target_id` is set,
   load and return that Individual.
3. **By primary email** — if the type has an `email` primary field, `loadByProperties([email_field
   => $order->getEmail()])` and return the first match.
4. Otherwise `NULL` → a new Individual is created.

This is why the target Individual type needs an **email** primary field: it is the only match path
for anonymous / not-yet-linked customers.

### `getData(OrderInterface $order): array` (protected) — building the payload

Starts with `['type' => $individual_type]`. If the order has a **billing profile**
(`ProfileInterface`):

- if the type has an `address` primary field → `$data[address_field] = $profile->address->getValue()[0]`;
- if the type has an `email` primary field → `$data[email_field] = $order->getEmail()`;
- always → `$data['name'] = ['given' => $profile->address->given_name, 'family' => $profile->address->family_name]`.

Then invokes the alter hook (below) and returns `$data`.

### `mapOrderToIndividual()` (public)

`getIndividual()` + `getData()`, then either `updateIndividual($data, $individual)` (existing) or
`createNewIndividual($data)` (new).

- `createNewIndividual(array $data)` → `storage('crm_core_individual')->create($data)`.
- `updateIndividual(array $data, $individual)` → `$individual->set($key, $value)` for each pair;
  throws `\Exception('Trying to change bundle of individual on update.')` if the incoming `type`
  differs from the Individual's current bundle.

Neither method `save()`s — the subscriber saves after validating.

## Customising the mapped data

### Option A — the alter hook

`getData()` calls `$this->moduleHandler->alter('crm_core_individual_data', $data, $order)`, so
implement:

```php
/**
 * Implements hook_crm_core_individual_data_alter().
 */
function MYMODULE_crm_core_individual_data_alter(array &$data, \Drupal\commerce_order\Entity\OrderInterface $order) {
  // Add/override fields on the individual before it is created/updated.
  $data['field_phone'] = $order->getBillingProfile()?->get('field_phone')->value;
}
```

Keys in `$data` are Individual field names; `type` must not be changed for an existing individual
(see `updateIndividual()`).

### Option B — extend the mapper service

Subclass `CrmCoreIndividualMapper` and override the protected `createNewIndividual()` /
`updateIndividual()` (or `getData()` / `getIndividual()`) as the README suggests, then point the
`crm_core_commerce.individual_mapper` service at your class via a `services.yml` in your own module
(or a `ServiceProvider`). The subscriber depends on the interface, so your override is used
automatically.
