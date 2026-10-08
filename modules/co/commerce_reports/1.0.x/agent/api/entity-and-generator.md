<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `commerce_order_report` entity, generator & order-placed flow

## The entity

`commerce_order_report` (`@ContentEntityType`, `base_table = commerce_order_report`). Base
fields: `report_id`, `uuid`, `type` (bundle = a report-type plugin id), `order_id` (entity
reference to `commerce_order`), `created`, `updated`. Bundle-specific fields come from each
report type's `buildFieldDefinitions()` (e.g. `order_report` adds `order_type_id`, `amount`
[commerce_price], `mail`, `billing_address`). Since `commerce_reports_update_10000`, the entity
uses `entity`'s `EntityAccessControlHandler` + `EntityPermissionProvider` (so it also has
per-entity CRUD permissions).

Create one directly (fields depend on bundle):

```php
$storage = \Drupal::entityTypeManager()->getStorage('commerce_order_report');
$report = $storage->create([
  'type' => 'order_report', 'order_id' => $order_id,
  'amount' => ['number' => '42.00', 'currency_code' => 'USD'],
  'mail' => 'buyer@example.com',
]);
$report->save();
```

## `OrderReportGenerator` (`commerce_reports.order_report_generator`)

- `generateReports(array $order_ids, $plugin_id = NULL)` — for each order, instantiate each
  report-type plugin (or just `$plugin_id`) and call its `generateReports($order)` to persist
  a `commerce_order_report`.
- `refreshReports(array $order_ids, $plugin_id = NULL)` — delete existing reports for those
  orders (optionally one type) then regenerate.

Helper: `commerce_reports.query_builder` (`ReportQueryBuilder`) builds the aggregate query used
by the report tables.

## Automatic capture on order placement

`commerce_reports.order_placed_subscriber` (`OrderPlacedEventSubscriber`, tagged
`event_subscriber` + `needs_destruction`) listens to
`commerce_order.place.post_transition`. `onOrderPlace()` records the order id; `destruct()`
calls `OrderReportGenerator::generateReports()` for all orders placed during the request. So a
report row per report type is created the first time an order transitions to *placed* — no cron.

## Views integration

`OrderReportViewsData` + Views plugins (`commerce_reports_report_date_field`,
`PriceNumericField`, `ReportDate` sort) power the shipped Views `sales_report` and
`purchased_items_report`, both based on the `commerce_order_report` table.
