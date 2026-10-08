<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# invoice_ninja — Drush & sync triggers

## Drush
- `drush invoice_ninja:synchronize_users` (alias `insu`) — synchronizes every user that has the sync permission, via `user.synchronizer`.

## Entity actions (VBO / ECA / core actions)
- `SyncClient`, `SyncInvoice`, `SyncVat` — extend `SyncBase`; call the matching synchronizer for the acted-on entity. Each synchronizer stores `remote_id` + `last_sync` in a key/value collection so the first run creates the remote record and later runs update it.

## ECA
- Condition `SyncStatus` — true/false on whether the entity is already synced (has a stored remote id). Use it to branch ECA models (e.g. create vs. update).

## REST
- `invoiceninja_client` REST resource: `GET/POST/PATCH/DELETE /api/invoiceninja-client/{id}`. It is a standard core-REST plugin over the `invoiceninja_client` key/value store — enable it (config import or REST UI) and grant its per-method permissions before use; access follows core REST, not a custom bypass.