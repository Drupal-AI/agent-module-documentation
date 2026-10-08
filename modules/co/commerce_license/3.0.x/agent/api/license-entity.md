# The License entity, events, cron, subscription type

## `commerce_license` entity

- Content entity, base table `commerce_license`, id key `license_id`, bundle key `type`,
  owner key `uid`. Admin permission `administer commerce_license`.
- **Bundle = a License type plugin** (`bundle_plugin_type = commerce_license_type`).
- Storage: `LicenseStorage` (`LicenseStorageInterface`). Route provider:
  `LicenseRouteProvider`. Permission provider: `LicensePermissionProvider`.
- Links: canonical `/admin/commerce/licenses/{commerce_license}`, add-page/add-form,
  edit-form, delete-form, collection `/admin/commerce/licenses`, and a
  `state-transition-form`.

### Notable base fields

| Field | Type | Notes |
|---|---|---|
| `state` | `state` (state_machine) | **required**; workflow `license_default` |
| `uid` / owner | entity_reference user | license owner (gets the grant) |
| `product_variation` | entity_reference | **required**; the licensed variation (validation-time) |
| `expiration_type` | `commerce_plugin_item:commerce_license_period` | **required**; the License period plugin |
| `expires` | timestamp | computed expiry; cron expires licenses past it |
| `granted` / `renewed` / `created` / `changed` | timestamp | lifecycle timestamps |
| `originating_order` | entity_reference commerce_order | the order that created it |
| (per bundle) e.g. `license_role` | — | added by the License type plugin |

`setRequired(TRUE)` fields are enforced at validation time, not on a raw `->save()`.

### Get / create

```php
$storage = \Drupal::entityTypeManager()->getStorage('commerce_license');
$license = $storage->load($id);
$state   = $license->getState()->getId();     // 'active', 'expired', ...
$owner   = $license->getOwnerId();

$new = $storage->create([
  'type' => 'role', 'state' => 'active', 'uid' => $uid,
  'license_role' => 'premium_member',
  'expiration_type' => ['target_plugin_id' => 'unlimited', 'target_plugin_configuration' => []],
]);
$new->save();
```

## Events (`LicenseEvents`)

`src/Event/LicenseEvents.php` defines constants (dispatched with a `LicenseEvent`) so other
modules can react to license lifecycle changes (grant/revoke/renew/expire etc.). Subscribe in
the usual event-subscriber way. The module's own subscribers (`LicenseSubscriber`,
`OrderSubscriber`, cart subscribers, `LogEventSubscriber`) drive activation and logging.

## Cron & Advanced Queue expiry

`Cron::run()` (`commerce_license.cron` / `CronInterface`) queries `active` and
`renewal_in_progress` licenses with `expires <= now` and enqueues a `commerce_license_expire`
job on the `commerce_license` Advanced Queue; a companion notify job/queue
(`commerce_license_notify`) handles pre-expiry notification. Job types:
`Plugin/AdvancedQueue/JobType/LicenseExpire` and `LicenseExpireNotify`.

## Subscription type (with commerce_recurring)

`Plugin/Commerce/SubscriptionType/LicenseSubscription.php` (`id = "license"`) integrates a
license with a Commerce Recurring subscription so the license renews with the billing
schedule. Requires the optional `commerce_recurring` module.
