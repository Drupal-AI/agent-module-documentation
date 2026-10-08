<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Customer address book (arch_addressbook) — agent index

Per-customer billing/shipping address store for the **Arch** suite, built on a user-owned
`addressbookitem` content entity. Package *Arch*. Depends on contrib **`address`**, core **`field`**
and **`views`**, plus **`arch`** and **`arch_order`**. Core `^9.4 || ^10 || ^11`. License
GPL-2.0-or-later.

## What it provides (from source)

- **Entity** — `addressbookitem` (`src/Entity/Addressbookitem.php`), fieldable, **revisionable**,
  translatable, user-owned. Install config adds an `address` field (Address module) and a `vat_id`
  field, plus `address`/`full`/`teaser` view modes. Handlers: access
  `AddressbookitemAccessControlHandler`, view builder `AddressbookitemViewBuilder`, list builder,
  views data.
- **Routes** (`arch_addressbook.routing.yml`):
  - canonical `/address/{addressbookitem}` (`_entity_access: addressbookitem.view`),
    edit/delete (`.edit` / `.delete`).
  - add `/address/add` (`_entity_create_access`) and `/user/{user}/addressbook/add`
    (`_custom_access: AddressbookitemForm::access`).
  - admin list `/admin/store/settings/addressbook/list` and settings
    `/admin/store/settings/addressbook` (`administer addressbookitem entity`, the configure route).
  - revision routes `/address/{addressbookitem}/revisions[/…]` guarded by
    `_access_addressbookitem_revision` (`Access/AddressbookRevisionAccessCheck`).
- **Permissions** — view / view own / add / add to any user / edit / edit own / delete / delete own
  `addressbookitem entity`, and `administer addressbookitem entity` (restricted).
- **Service** — `addressbookitem.user_addresses` (`Services/UserAddressesService`) resolves a user's
  addresses; `AddressbookAdminRouteSubscriber` re-parents the admin routes; access check service
  `access_check.addressbookitem.revision`.
- **Views** — `views.view.addressbook`, `views.view.addresses` (config/optional), row plugin
  `AddressbookitemRow`, local-action derivative `ArchAddressbookLocalAction`.

## Access model

`AddressbookitemAccessControlHandler::checkAccess()`: `administer addressbookitem entity` allows all;
otherwise an authenticated owner (`$account->id() == $entity->getOwnerId()`) is allowed with the
matching `… own addressbookitem entity` permission, and non-owners need the corresponding non-own
permission. `AddressbookitemForm::access()` lets a user add to their own account with
`add addressbookitem entity`, or to any account with `add addressbookitem entity to any user`.
