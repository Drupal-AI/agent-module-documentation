<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions & access model

## Permissions (`commerce_funds.permissions.yml`)

Admin (each `restrict access: TRUE`):
- `administer funds` — access all the `commerce_funds.settings.*` configuration forms.
- `administer transactions` — view *all* transactions, all user balances, the site balance, and operate
  with the site balance. Also the entity `admin_permission`. Users with it are charged **no fees** and
  their wallet is stored as the site balance (`uid = 1`).
- `administer withdrawal requests` — approve/decline withdrawal requests
  (`commerce_funds.admin.withdrawal_requests.approve|decline`); also grants access to any user's
  withdrawal-methods pages.

User (each `restrict access: FALSE`):
- `view own transactions` — the user-facing transaction views under `/user/funds/*`.
- `deposit funds` — deposit into own balance and buy products with it (route `commerce_funds.deposit`;
  also gates the `payment` transaction bundle).
- `create escrow payment` — create/release/cancel escrow (routes `commerce_funds.escrow*`).
- `transfer funds` — transfer to other users (route `commerce_funds.transfer`).
- `withdraw funds` — submit withdrawal requests and manage own withdrawal methods
  (routes `commerce_funds.withdraw`, `commerce_funds.withdrawal_methods*`).
- `convert currencies` — currency conversion (route `commerce_funds.convert_currencies`); requires the
  `commerce_exchanger` module to be usable.

Live check: `ddev drush role:perm:list` / `ddev drush user:role:add`.

## Route gating (`commerce_funds.routing.yml`)

Most user routes use a single `_permission` requirement matching the list above. Approval/decline routes
require `administer withdrawal requests`. The withdrawal-methods routes use a custom access check
(below). Escrow release/cancel and the approval/decline routes take a random `{transaction_hash}` /
`{request_hash}` (regex `^(\w|-)+$`) rather than an entity id.

## Custom access check — withdrawal methods

`Access\WithdrawalMethodAccessCheck::checkAccess` (`_custom_access` on
`commerce_funds.withdrawal_methods` and `.edit`): allowed if the account has
`administer withdrawal requests`; otherwise allowed only when **viewing one's own** user
(`$route_user->id() == $account->id()`) **and** the account has `withdraw funds` (cache per user). So a
non-admin can only reach their own payout details, not another user's.

## Entity access — `TransactionAccessControlHandler`

- **view**: allowed for `administer transactions`, or when the account is the transaction's `issuer` or
  `recipient`; otherwise forbidden.
- **delete**: always forbidden ("Transaction should not be deleted but only canceled.").
- **create** (`checkCreateAccess`, per bundle): `deposit`→`deposit funds`; `transfer`→`transfer funds`;
  `payment`→`deposit funds`; `escrow`→`create escrow payment`; `withdrawal_request`→`administer
  withdrawal requests`; `conversion`→`convert currencies`. This `create` check is what
  `TransactionManager::performTransaction()` calls (`$transaction->access('create', $account)`) before
  applying balance effects for each bundle.

## Confirm-form ownership checks

The escrow release/cancel confirm forms additionally enforce ownership in `isUserAllowed()`: release
requires `currentUser == issuer` and status `Pending`; cancel requires `currentUser == issuer || recipient`
and status `Pending`; anything else 404s.
