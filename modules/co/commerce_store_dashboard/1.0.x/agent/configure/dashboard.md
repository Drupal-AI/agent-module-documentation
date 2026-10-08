<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring the store dashboard

## Access model (`CommerceStoreDashboardAccessCheck::access`)
A user can view `/store/{commerce_store}/dashboard` when either:
- they have **`bypass commerce_store dashboard access`** (restricted — "see any store"), or
- they **own** the store (`$store->getOwnerId() === $account->id()`) **and** have **`access own commerce_store dashboard`**.

Otherwise access is forbidden. Allowed results add the `user` cache context; denials add `user.permissions`.

## Setting it up
1. Enable the module (pulls in `commerce_store`).
2. Assign permissions: give store owners `access own commerce_store dashboard`; give staff who manage all stores `bypass commerce_store dashboard access`.
3. Configure the **`dashboard`** view mode of the Commerce Store entity (Manage display) to lay out the fields/blocks/views you want owners to see.
4. Link owners to `/store/<id>/dashboard` (a contextual link is also provided).

## Notes
No data is mutated by this module; it is a display + access layer over the store entity. Keep `bypass commerce_store dashboard access` limited since it reveals every store's dashboard.
