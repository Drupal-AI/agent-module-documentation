<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Addressbookitem entity, access & UserAddressesService

## Install & enable

```bash
drush en arch_addressbook -y
```

Depends on `address`, `field`, `views`, `arch`, `arch_order`. On install it creates the
`addressbookitem` entity plus its fields (`address`, `vat_id`) and view modes from `config/install`,
and the `addressbook` / `addresses` Views from `config/optional`.

## The entity

`Entity\Addressbookitem` — a **content entity**, revisionable and user-owned (an owner/uid key).
Bundle `addressbookitem`. Fields:

- **`address`** — an [Address module](https://www.drupal.org/project/address) field
  (`field.storage.addressbookitem.address`), country-aware postal address.
- **`vat_id`** — a string VAT identifier (`field.storage.addressbookitem.vat_id`).

View modes: `address`, `full`, `teaser`. Handlers include `AddressbookitemViewBuilder`,
`Entity\Controller\AddressbookitemListBuilder`, `Entity\Views\AddressbookitemViewsData`, and the
forms below. Templates: `templates/addressbookitem.html.twig`.

## Forms & controllers

- `Form\AddressbookitemForm` (add/edit) — also exposes a static `access()` used as the custom access
  callback for the `add_to_user` route.
- `Form\AddressbookitemDeleteForm`, `Form\AddressbookitemRevisionRevertForm`,
  `Form\AddressbookitemSettingsForm`.
- `Controller\AddressbookController` — revision overview / show / revert plumbing
  (`getRevisionIds()` uses an entity revision query).
- `Controller\AddressbookViewController::view()` — renders a single item (mirrors core's entity
  view controller, including the anonymous-crawler access fallback).

## Routes & permissions

See start.md for the full table. Permissions (`arch_addressbook.permissions.yml`): `view`,
`view own`, `add … to any user`, `add`, `edit`, `edit own`, `delete`, `delete own`
`addressbookitem entity`, and `administer addressbookitem entity` (**restricted**). The `settings`
and `collection` (admin list) routes require `administer addressbookitem entity`. Revision routes
use the `_access_addressbookitem_revision` check (`Access\AddressbookRevisionAccessCheck`).

## Access control (`AddressbookitemAccessControlHandler::checkAccess`)

1. Holder of `administer addressbookitem entity` (authenticated) → allowed for any operation.
2. For `view`/`edit`/`delete`, an **authenticated owner** (`$account->id() == $entity->getOwnerId()`)
   who lacks the broad permission but holds the corresponding `… own …` permission → allowed
   (cache per user + per permissions + entity).
3. Otherwise the broad `view|edit|delete addressbookitem entity` permission is required.
4. `checkCreateAccess()` → `administer` or `add addressbookitem entity`.

Net effect: a normal customer (holding the `own` + `add` permissions) can manage only their own
addresses; viewing/editing another customer's address requires the non-`own` permission or
`administer`. The owner comparison is a strict id match, so there is no cross-user id-guessing bypass
on these routes.

## UserAddressesService (service id `addressbookitem.user_addresses`)

`Services\UserAddressesService` — inject it to fetch a user's saved addresses:

- `getByUser($user, …)` — addresses owned by a given user.
- `getByProperties(array $properties)` — entity-query lookup (`condition($name, (array) $value,
  'IN')`, `accessCheck(FALSE)` because it is an internal owner-scoped lookup). Returns loaded
  Addressbookitem entities.

Use it (for example) to populate an address selector at checkout for the current customer.

## Notes

- All storage access is via the entity API / entity queries — no raw SQL. Address rendering uses the
  Address module's formatters, so postal data is escaped by core field rendering.
- `AddressbookAdminRouteSubscriber` marks the entity admin routes as admin routes; a local-action
  derivative adds the contextual "add address" actions.
