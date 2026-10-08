<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# New Relic Transactions (newrelic_transactions) — agent index

Renames New Relic APM transactions by **route + entity bundle + highest-weight role** instead of the
PHP entry point, and can attach the current user's **id** and **roles** as New Relic custom
parameters. Version **1.0.5**. Core `^8.8 || ^9 || ^10 || ^11`. Package: New Relic. License
GPL-2.0-or-later. No dependencies beyond core; needs the **`newrelic` PHP extension** at runtime.

## The problem it fixes
Without help, the New Relic PHP agent sees **`index.php` for every request**, so a Drupal site's whole
traffic collapses into one transaction bucket and the dashboard reports a single average that is
**true and useless**. New Relic otherwise groups by whichever low-level function ran most (permission
checks, menu loading), not by the action the user took.

## Mechanism (read the source, don't guess)
- Single service `newrelic_transactions.event_subscriber` →
  `src/EventSubscriber/EventSubscriber.php`, an `EventSubscriberInterface`.
- **`getSubscribedEvents()` registers nothing unless `extension_loaded('newrelic')` is true**, and
  both callbacks re-check `extension_loaded('newrelic')` on entry — so the `newrelic_*` functions are
  never called when the extension is absent (no fatal). Both subscribe to `KernelEvents::REQUEST`.
- `nameTransaction()`:
  - Skips sub-requests (compares route object to the master route match's route object).
  - Takes the route **path** (`$route->getPath()`); for each route parameter that is an object with a
    `bundle()` method (i.e. an entity), replaces `{param}` in the path with `{bundle}` — so
    `/node/{node}` becomes `/node/{article}`.
  - Picks the current user's **highest-weight** matching role. `transaction_roles` config limits which
    roles count; if empty, all `user_role` entities are considered. No matching role → `other`.
  - Calls `newrelic_name_transaction(substr($path, 1) . ' (' . $role . ')')` — e.g.
    `node/{article} (authenticated)`.
- `addAttributes()`: gated by the `user_data` config. If `id` enabled →
  `newrelic_add_custom_parameter('user_id', $user->id())`; if `roles` enabled →
  `newrelic_add_custom_parameter('user_roles', implode(', ', $user->getRoles()))`. Nothing else is
  sent — no email, no session, no request params.

## Configuration
- Route `newrelic_transactions.config` → `/admin/config/development/newrelic-transactions`, guarded by
  the **`administer site configuration`** permission (`src/Form/NewRelicTransactionsConfig.php`).
- Config object `newrelic_transactions.config` with two `checkboxes` fields:
  - `transaction_roles` — limit which roles may be appended to the name (blank = all roles).
  - `user_data` — which custom parameters to send: `id`, `roles`. **Ships default off** (install config
    sets every value to `"0"`).
- The form shows an error message if the `newrelic` extension is missing; `hook_requirements()` also
  reports extension presence on the status report (WARNING if absent).

## Two things worth attaching
1. **Cardinality is the constraint.** An APM aggregates (and bills) by **distinct transaction name**.
   Naming by an entity **id** would produce a name per node and bury the signal — route + bundle +
   role is a deliberate choice of three **low-cardinality** dimensions. Correct by design.
2. **Role/id in the APM is a small, opt-in disclosure.** The role suffix reveals which roles exist and
   how traffic distributes; the `user_data` parameters send uid/roles to a third party. Both are
   unremarkable for most sites, off by default, and never include emails, tokens, or session data.
