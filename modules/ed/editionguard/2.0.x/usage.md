<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Edition Guard integrates the EditionGuard DRM ebook service with Drupal, modelling books and per-user download transactions as content entities.

---

It defines two content entity types — `editionguard_book` (title, EditionGuard resource id, DRM type, a private-scheme file field) and `editionguard_transaction` (owner, book, EditionGuard transaction id, download link, uses-remaining, watermark). Creating a transaction (`TransactionCreateForm`) or regenerating one (`TransactionRegenerateController`) calls the EditionGuard REST API through the required `editionguard_api` module's client (`editionguard_api.client`): it deletes any old transaction, then requests a new one with the book's resource id, external id and optional EditionMark watermark parameters (buyer name/email), and stores the returned download link on the transaction entity. Books' source files are saved to a private file scheme (`_editionguard_file_default_scheme()` excludes public). An optional `rh_editionguard_book` submodule adds a Rabbit Hole plugin for book entities.

All operations are permission-gated: books use `administer editionguard_book` plus granular add/edit/delete/view permissions; transactions use `create`, `regenerate` and `change book editionguard_transaction`. The regenerate route (`/editionguard/transaction/{transaction}/regenerate`) requires `regenerate editionguard_transaction`. The actual EditionGuard API credentials/TLS live in the separate `editionguard_api` module, which calls `https://app.editionguard.com` over HTTPS with default TLS verification and an OAuth/token `Authorization` header sourced from its own config (no secret hardcoded in this module).

Setup: enable the module (pulls `editionguard_api`), configure the EditionGuard API credentials in `editionguard_api` settings, optionally set a book prefix, then add books and create transactions.

---
- Model DRM ebooks as `editionguard_book` entities
- Store an EditionGuard resource id and DRM type per book
- Keep ebook source files in the private file scheme
- Create a download transaction for a user and book
- Regenerate a transaction (delete old, request new)
- Allocate a transaction to a different book
- Apply an EditionMark watermark with the buyer's name/email
- Place watermarks at start/end/random locations
- Limit a transaction's uses-remaining
- Store the returned EditionGuard download link
- List books and transactions in admin collections
- Grant granular book add/edit/delete/view permissions
- Grant transaction create/regenerate/change-book permissions
- Bridge Commerce orders to EditionGuard (via companion module)
- Translate book entities (translation handler)
- Provide a Views data source for books and transactions
- Set an optional book prefix in settings
- Add Rabbit Hole behavior to books via the submodule
- Regenerate a broken/expired download link
- Show books via Views (reference field hidden on front end)