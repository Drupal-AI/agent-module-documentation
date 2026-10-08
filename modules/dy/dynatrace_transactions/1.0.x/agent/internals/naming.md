<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How the transaction name is computed

Source: `src/EventSubscriber/EventSubscriber.php`, method `computeTransactionName($event)`.

## When it runs

- Subscribes to `KernelEvents::REQUEST` at **priority 28** (`getSubscribedEvents()`), i.e. **before**
  core's `DynamicPageCacheSubscriber` (priority 27), so the name is set for cacheable master
  requests too.
- **Sub-requests are skipped:** if `$route_match->getRouteObject()` differs from
  `getMasterRouteMatch()->getRouteObject()`, the method returns early. Only the master request gets
  named.

## The algorithm

1. Load config `dynatrace_transactions.config`.
2. Take the matched route's **path template**: `$route = $route_match->getRouteObject();
   $path = $route->getPath();` (e.g. `/node/{node}`). This is the static route definition string,
   **not** the raw request URL.
3. **Bundle substitution:** loop `$route_match->getParameters()`; for any parameter object that has a
   `bundle()` method (i.e. a content entity), replace `{key}` with `{bundle()}` in the path —
   `/node/{node}` → `/node/{article}`.
4. **Enabled roles:** `$config->get('transaction_roles')`, then `array_filter()` to keep only truthy
   (checked) entries. **If none are enabled, ALL system roles are used** (loads every `user_role`
   entity and uses their IDs). See [config/settings.md](../config/settings.md).
5. **User's role:** `\Drupal::currentUser()->getRoles()`, filtered to the enabled set with
   `in_array()`.
6. **Highest weight wins:** `array_pop()` on the filtered user-roles array takes the **last** role.
   Role weight ordering comes from how `getRoles()`/role storage returns them (reorder roles at
   `/admin/people/roles`). Only **one** role is appended.
7. **Fallback:** if the user has no enabled role, `$transaction_role = "other"`.
8. **Set the name:** `substr($path, 1)` (drops the leading `/`) + ` (role)`, passed to
   `$this->transactionNamer->setTransactionName(...)`. Example result: `node/{article} (editor)`.

## Notes for operators

- Names are built entirely from Drupal route templates, entity **bundle machine names**, and **role
  machine names** — all developer/admin-defined identifiers, not free-form request input.
- Route-less requests (no route object) will error on `getPath()` in edge cases; in normal Drupal
  request flow a master request has a resolved route by REQUEST priority 28.
- To make Dynatrace actually use this name, configure a **request attribute** in Dynatrace that
  captures the argument to `Drupal\dynatrace_transactions\TransactionNamer::setTransactionName`
  (see [api/transaction-namer.md](../api/transaction-namer.md)).
