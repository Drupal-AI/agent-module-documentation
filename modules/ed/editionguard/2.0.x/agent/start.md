<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Edition Guard (editionguard) — agent index
**Manages EditionGuard DRM ebooks and per-user download transactions as Drupal entities.**

- **Version:** 2.0.x (2.0.0-rc1)  •  **Core:** ^10 || ^11  •  **Requires:** editionguard_api
- **Config route:** `entity.editionguard_book.collection` (book list); settings add a book prefix
- **Entities:** `editionguard_book` (resource id, DRM type, private file), `editionguard_transaction`
- **Routes:** `editionguard.transaction.create` (`create editionguard_transaction`); `.change_book` (`change book editionguard_transaction`); `.regenerate` `/editionguard/transaction/{transaction}/regenerate` (`regenerate editionguard_transaction`)
- **API:** calls `editionguard_api.client` (transaction_create/_delete endpoints) — that module talks to `https://app.editionguard.com` over HTTPS (default TLS verify), OAuth/token `Authorization` header from its own config
- **Security:** every route/entity op is permission-gated (granular book + transaction perms; admin perms `restrict access: true`); book files use a private scheme. No anonymous or mutating public endpoints; no disabled TLS, client-set amount or hardcoded secret in this module (credentials live in editionguard_api config).

See [configure/books-transactions.md](configure/books-transactions.md).