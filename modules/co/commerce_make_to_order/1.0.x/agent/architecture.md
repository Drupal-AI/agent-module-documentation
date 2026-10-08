<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# commerce_make_to_order — architecture

## Workflow (`commerce_make_to_order.workflows.yml`)
`mto_order_default`, group `commerce_make_to_order`.

States: `draft`, `queued`, `waiting_for_materials`, `in_production`, `quality_check`, `rework`, `completed`, `canceled`.

Transitions: `queue` (draft→queued), `start` (queued→in_production), `wait_for_materials` ({queued,in_production,rework}→waiting_for_materials), `materials_received` (waiting_for_materials→queued), `send_to_qc` (in_production→quality_check), `qc_pass` (quality_check→completed), `qc_fail` (quality_check→rework), `rework_to_qc` (rework→quality_check), `cancel` ({draft,queued,in_production,waiting_for_materials,quality_check,rework}→canceled).

Workflow group registered in `commerce_make_to_order.workflow_groups.yml` (entity type `mto_order`). Custom workflows: define your own in a `*.workflows.yml` with `group: commerce_make_to_order` and select it per MTO order type.

## Timestamps & state history
- `StateTransitionSubscriber` (pre_transition): `start` sets `started_at` (once), `qc_pass` sets `completed_at`. `shipped_at` is set by shipment sync (see below). Uses pre_transition to avoid re-saving inside the subscriber.
- `MtoOrderStateHistorySubscriber` → `MtoOrderStateHistoryService` writes a row to `mto_order_state_history` on every transition, backfilling the previous state's `duration`. Creation recorded in `hook_mto_order_insert`.
- `MtoOrderLogSubscriber` (post_transition): writes a `mto_order_state_updated` Commerce Log entry (from/to labels + transition label).

## Auto-creation (`OrderCompleteSubscriber`)
`commerce_order.post_transition` (priority -100). For each `mto_order_type` with `autoCreate` and `autoCreateOnState === $to_state` (default `paid`), creates one `mto_order` per order item. Dedupes on `(order_item, type)`. Copies `quantity` from the item, sets `state=draft`, applies `defaultAssigned`, `estimatedCompletionDays` (created + N days), and — when shipment integration is on — links the item's existing checkout shipment. Dispatches `MtoOrderEvents::MTO_ORDER_CREATE` before save. Same logic in the Drush command (`src/Drush/Commands/MtoCommands.php`).

## Commerce-order integration modes (per MTO order type)
Config keys on `mto_order_type`: `syncStateToOrder`, `syncMtoState`/`syncOrderState`, `shipmentIntegrationEnabled`, `shipmentTriggerState`/`orderReadyState`, `holdStates`.

- **Disabled** (default): MTO orders tracked independently.
- **State-sync** (`MtoOrderStateSyncSubscriber`): listens on selected `commerce_make_to_order.<transition>.post_transition`. When the MTO reaches `syncMtoState` and **all** MTO orders of that type on the Commerce order are in that state, finds a Commerce-order transition reaching `syncOrderState` and applies it (`applyTransitionById` + save). Skipped if shipment integration is on.
- **Shipment-integration** (`MtoOrderShipmentSubscriber`, requires `commerce_shipping`): same aggregate check; promotes the Commerce order to `orderReadyState` (default `ready_to_ship`). MTO↔shipment references are kept current by `MtoShipmentSyncSubscriber` (new/edited/deleted shipments; clears refs on incomplete MTOs when a shipment ships). `hook_form_alter` annotates shipment-item checkboxes with each item's MTO number + state indicator (✓/○/✗).
- **Hold states**: if the Commerce order's state is in `holdStates`, both sync subscribers skip the transition and instead log a `commerce_order_mto_note` telling staff to promote manually. Update hook `_10004` seeded existing types with `['on_hold']`.

`OrderAmendSubscriber` (optional `commerce_order_amend`): on a `SwapItem` amend, auto-syncs the MTO for items still in `draft`/`queued`; otherwise logs a warning + order note for manual review.

## Services (`*.services.yml`)
- `commerce_make_to_order.analytics` → `MtoOrderAnalyticsService` (per-order metrics, aggregates, on-time delivery, throughput, priority/cancellation breakdown, team performance, materials-wait; delegates state-history metrics). All DB reads via parameterized `Connection` queries; date filters run through `strtotime()` into bound conditions.
- `commerce_make_to_order.state_history` → `MtoOrderStateHistoryService` (record/query transitions, bottleneck + QC metrics).
- `commerce_make_to_order.cancel_guard` → `MtoOrderCancelGuard` (state_machine.guard): blocks the `cancel` transition unless the user has `administer mto orders` or `cancel mto orders`.
- `MtoOrderCacheSubscriber` invalidates `mto_order_list` on transitions (dashboard/analytics freshness).

## Presentation
- Entity view uses `mto-order.html.twig`; `hook_entity_extra_field_info` adds pseudo-fields **Activity Log** and **Production Metrics** to `mto_order` display and an **MTO Orders** table to `commerce_order` display.
- Dashboard: `MtoOrderDashboardBlock` (plugin `mto_order_dashboard`) — state counts + overdue count; injected into the `commerce_mto_orders` view header via `hook_preprocess_views_view`.
- Views: `views.view.commerce_mto_orders` with custom filter plugins (`mto_priority`, `mto_assigned_user`, `mto_overdue`) wired in `hook_views_data_alter`; `MtoOrderDueDateFormatter` renders due dates as gray/red pill badges.
- Templates: `mto-activity-log`, `mto-analytics-report`, `mto-order-dashboard`, `mto-order`, `mto-order-metrics`. Commerce Log templates in `*.commerce_log_templates.yml` (note bodies use `{{ note|nl2br }}` — Twig-escaped).

## Install/update notes
`hook_schema` creates `mto_order_state_history`. Updates: `10001` create table, `10002` backfill history from Commerce Log, `10003` add `estimated_completion_date` field + `estimatedCompletionDays`, `10004` seed `holdStates`. `hook_modules_installed/uninstalled` add/remove the `shipment` field storage when `commerce_shipping` toggles.
