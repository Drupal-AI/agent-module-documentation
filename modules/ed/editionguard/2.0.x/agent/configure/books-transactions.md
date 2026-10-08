<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Edition Guard — books & transactions

## Enable & configure
Enabling `editionguard` pulls `editionguard_api`. Set the EditionGuard API credentials on the
`editionguard_api` settings form (OAuth email/password and/or token — stored in
`editionguard_api.settings`, sent to `https://app.editionguard.com` over HTTPS). Optionally set a
book prefix in the EditionGuard book settings.

## Books (`editionguard_book`)
Admin collection at `/admin/structure/editionguard_book` (permission `administer editionguard_book`,
plus `add/edit/delete/view published/view unpublished editionguard_book`). Each book holds the
EditionGuard **resource id**, **DRM type**, and a source file stored in a **private** scheme.

## Transactions (`editionguard_transaction`)
- **Create:** `/admin/structure/editionguard_book/transaction/create` (`create editionguard_transaction`)
  → `TransactionCreateForm` builds `form_params` (resource_id, show_instructions, external_id,
  optional uses_remaining, and EditionMark watermark fields when DRM type = 3) and calls
  `editionguard_api.client->request(transaction_create,…)`; stores `transaction_id`,
  `resource_id`, `download_link` on the entity.
- **Regenerate:** `/editionguard/transaction/{transaction}/regenerate` (`regenerate editionguard_transaction`)
  → deletes the old EditionGuard transaction then requests a fresh one (new download link).
- **Change book:** `/admin/structure/editionguard_book/transaction/{transaction}/change_book`
  (`change book editionguard_transaction`).

## Automation
Programmatic transaction creation (e.g. from Commerce) mirrors `TransactionCreateForm`; see the
`commerce_editionguard` project. Optional `rh_editionguard_book` submodule adds Rabbit Hole
behavior to book entities.