<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Developer API

## Services (`commerce_order_withdrawal.services.yml`)
- `commerce_order_withdrawal.eligibility` (`WithdrawalEligibility`) —
  `check(OrderInterface): EligibilityResult`, plus `getWindowStart(OrderInterface): ?int`
  and `getWindowSeconds(): int`. Args: `entity_type.manager`, `datetime.time`,
  `event_dispatcher`, `string_translation`, `commerce_order_withdrawal.working_day_calendar`.
- `commerce_order_withdrawal.processor` (`WithdrawalProcessor`) —
  `process(OrderInterface $order, string $email): void` (stamp + log + email + REQUEST event).
  Args include `commerce.mail_handler`, `token`, `datetime.time`.
- `commerce_order_withdrawal.link_builder` (`WithdrawalLinkBuilder`,
  `TrustedCallbackInterface`) — `getUrlForOrder(OrderInterface): Url`,
  `getLinkElement(OrderInterface $order, string $variant): array` (returns a `#lazy_builder`
  placeholder; `renderLink` is the trusted callback). Returns `[]` for missing, guest
  (no customer), or ineligible orders. `$variant` is `'display'` ("Request withdrawal") or
  `'views'` ("Withdrawal").
- `commerce_order_withdrawal.working_day_calendar` (`WorkingDayCalendar`) —
  `extendDeadline(int, ?string): int`. Arg: `config.factory`.

## Events (`WithdrawalEvents`)
| Constant | Name | Class | Purpose |
| --- | --- | --- | --- |
| `REQUEST` | `commerce_order_withdrawal.request` | `WithdrawalRequestEvent` | Fired **after** a request is logged + acknowledged. React here (cancel/refund, notify a CRM). `getOrder()`, `getEmail()`. |
| `ELIGIBILITY` | `commerce_order_withdrawal.eligibility` | `WithdrawalEligibilityEvent` | Fired at the **end** of an eligibility check (after all built-in checks pass). **Deny-only**: `deny(string $reason)` (first wins), `isDenied()`, `getReason()`, `getOrder()`. Cannot override a built-in denial. |
| `WINDOW` | `commerce_order_withdrawal.window` | `WithdrawalWindowEvent` | Fired while computing the window start (seeded with placed time). `setStartTime(int)` moves the anchor (e.g. reception date); `markPending()` = clock not started / cannot expire; the two are mutually exclusive (last call wins). `getStartTime(): ?int`, `isPending()`, `getOrder()`. Window length is unchanged. |

Example subscriber to react to a request:
```php
public static function getSubscribedEvents(): array {
  return [WithdrawalEvents::REQUEST => 'onRequest'];
}
public function onRequest(WithdrawalRequestEvent $event): void {
  $order = $event->getOrder();
  // e.g. transition to canceled, initiate a refund…
}
```

## Base field & order-type settings
- `hook_entity_base_field_info()` adds `withdrawn` (timestamp) to `commerce_order`,
  display/form-configurable. Set by the processor; read by the already-withdrawn check and
  the confirmation template.
- `hook_form_commerce_order_type_form_alter()` adds the *Order withdrawal* details section
  with `enabled` (checkbox), `withdraw_subject`, `withdraw_bcc`; persisted as third-party
  settings under `commerce_order_withdrawal` (schema in
  `config/schema/commerce_order_withdrawal.schema.yml`). Token help shown when `token` is
  enabled.

## Link integration hooks
- `hook_entity_extra_field_info()` registers the `withdrawal_link` display pseudo-field
  (default hidden) per order-type bundle; `hook_commerce_order_view()` fills it from the
  link builder when the component is enabled.
- `hook_views_data_alter()` registers the `commerce_order_withdrawal_link` Views field
  (plugin `OrderWithdrawalLink`, `#[ViewsField]`), rendered from the row entity via the link
  builder.

## Theme & log
- `hook_theme()` → `commerce_order_withdrawal_confirmation` (variable `order_entity`),
  template `templates/commerce-order-withdrawal-confirmation.html.twig` (override in theme;
  no configurable body field).
- `commerce_order_withdrawal.commerce_log_templates.yml` defines
  `order_withdrawal_requested` (category `commerce_order`).

## Tests
Kernel + Unit tests under `tests/`: eligibility (incl. working-day deadline), processor
(stamp/log/email/event), both forms, the user-route access control
(`OrderWithdrawalUserAccessTest`), link builder, and the three events. A test submodule
`commerce_order_withdrawal_event_test` provides subscribers.
