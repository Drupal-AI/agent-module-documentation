<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Acquisition API (find-or-create users)

Service **`decoupled_auth.acquisition`** → `Drupal\decoupled_auth\AcquisitionService` implements
`AcquisitionServiceInterface`. Constructor args: `@config.factory`, `@entity_type.manager`,
`@event_dispatcher`.

## `acquire(array $values, array $context = [], &$method = NULL)`

Finds a matching user or creates one. Returns a `DecoupledAuthUser|null`; `$method` is filled with
`'acquire'` (matched) or `'create'` (new). Flow (`AcquisitionService::acquire()`):

1. Merges `$context` over the service defaults (see below).
2. Dispatches `AcquisitionEvent::PRE` (`'decoupled_auth.pre_acquire'`) — subscribers may edit `$values`
   and `$context` by reference.
3. `findMatch()` runs an entity query on `user`.
4. If no match **and** `BEHAVIOR_PREFER_COUPLED` is set, re-runs `findMatch()` with that flag removed.
5. If matched → `$method='acquire'`. Else if `BEHAVIOR_CREATE` set → `$method='create'`,
   `$user = userStorage->create()`. Else `NULL`.
6. Dispatches `AcquisitionEvent::POST` (`'decoupled_auth.post_acquire'`) with the resulting `$user`.

`getFailCode()` returns the last failure: `FAIL_NO_VALUES` (1), `FAIL_NO_MATCHES` (2),
`FAIL_MULTIPLE_MATCHES` (3), or NULL.

## `$values`

Field => expected value conditions (any user field), applied as simple `condition()`s. Special key
**`decoupled`**: `TRUE` → `notExists('name')` (decoupled only), `FALSE` → `exists('name')` (coupled
only). NULL values are skipped.

## `$context`

- `name` — optional identifier; when set, the query is also tagged
  `decoupled_auth_acquisition__<name>` (plus the always-present tag `decoupled_auth_acquisition`).
  Recommended so event subscribers can target a specific process.
- `conjunction` — `'AND'` (default) or `'OR'` for combining `$values`.
- `behavior` — bit flags (`AcquisitionServiceInterface`):
  - `BEHAVIOR_FIRST` (0x1) — take the first of multiple matches (query `range(0,1)`); otherwise the
    query fetches 2 and multiple matches are rejected as `FAIL_MULTIPLE_MATCHES`.
  - `BEHAVIOR_CREATE` (0x2) — create a new user when nothing matched.
  - `BEHAVIOR_PREFER_COUPLED` (0x4) — prefer coupled users (`exists('name')`); falls back to a second
    pass without this flag if no coupled match.
  - `BEHAVIOR_INCLUDE_PROTECTED_ROLES` (0x8) — include users holding a protected role. By default
    protected roles (`acquisitions.protected_roles`, default `administrator`) are **excluded** via an
    OR group (`roles NOT IN protected` OR `roles` not set).

Service default context: `['name'=>NULL, 'conjunction'=>'AND', 'behavior'=>BEHAVIOR_CREATE |
BEHAVIOR_PREFER_COUPLED]`, plus `BEHAVIOR_FIRST` added when `acquisitions.behavior_first` config is on.

The `findMatch()` query uses `accessCheck(FALSE)` (a system-level match, not acting as the current
user) — callers are responsible for gating who may trigger an acquisition.

## `AcquisitionEvent`

Constructed with `(&$values, &$context, ?DecoupledAuthUser $user = NULL)`. Accessors return by
reference: `getValues()`, `getContext()`, `getName()` (`$context['name']`), `getUser()`. Subscribe to
`AcquisitionEvent::PRE` to alter the query inputs, `::POST` to react to the outcome.

## Example

```php
/** @var \Drupal\decoupled_auth\AcquisitionServiceInterface $acq */
$acq = \Drupal::service('decoupled_auth.acquisition');
$user = $acq->acquire(
  ['mail' => 'jo@example.com', 'decoupled' => TRUE],
  ['name' => 'my_import', 'behavior' => AcquisitionServiceInterface::BEHAVIOR_CREATE],
  $method
);
// $method === 'acquire' (reused existing decoupled record) or 'create' (new).
```
