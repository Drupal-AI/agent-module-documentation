<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Pushes Drupal entities (users/clients, VAT rates, invoices) into an Invoice Ninja account through the `invoiceninja/sdk` client.

---

The module wraps the Invoice Ninja PHP SDK behind a set of synchronizer services (`user.synchronizer`, `client.synchronizer`, `vat.synchronizer`, `invoice.synchronizer`). Each keeps a local key/value map of Drupal-id → remote-id plus a last-sync timestamp so records are created once and updated thereafter. Synchronization is triggered three ways: entity actions (`Sync Client`, `Sync Invoice`, `Sync VAT`) that can be run from VBO/ECA, an ECA condition plugin (`SyncStatus`) that reports whether an entity is already synced, and a Drush command that batch-syncs users. A `ClientResource` REST plugin also exposes the local client key/value store at `/api/invoiceninja-client/{id}` (disabled until you enable the REST resource and grant its permissions).

Setup is a single admin form at `/admin/config/system/invoice_ninja` (permission `administer invoice_ninja configuration`): the Invoice Ninja base URL, an API token, a "synchronize users" toggle, and an admin-user password used for certain requests. **Operational/security note:** the API token and the admin password are saved directly into the `invoice_ninja.settings` config object in plaintext (no Key-module / secrets integration), so they land in config export and the DB — treat the config as sensitive and exclude it from committed config where possible. The token/URL are handed to the SDK as-is; TLS is left at the SDK default (not disabled by this module). Which users get synced is gated by the `access invoice_ninja` / `administer invoice_ninja` permissions.

---

- Connect Drupal to an Invoice Ninja instance (URL + API token) from one admin form.
- Store the Invoice Ninja base URL and API token in `invoice_ninja.settings`.
- Enable user synchronization and set the admin-user password for privileged requests.
- Sync all permitted users to Invoice Ninja with `drush invoice_ninja:synchronize_users` (alias `insu`).
- Sync a single client entity via the `SyncClient` action (VBO / ECA / core action).
- Sync an invoice via the `SyncInvoice` action.
- Sync a VAT rate via the `SyncVat` action.
- Branch an ECA model on whether an entity is already synced using the `SyncStatus` condition.
- Keep a local Drupal-id → Invoice-Ninja-id map in the key/value store per entity type.
- Create a remote record on first sync and update it on subsequent syncs automatically.
- Grant `administer invoice_ninja configuration` to let an admin edit the connection settings.
- Grant `access invoice_ninja` / `administer invoice_ninja` to control which users are synced.
- Expose the local client key/value store over REST at `/api/invoiceninja-client/{id}` (after enabling the resource).
- Create client records via `POST /api/invoiceninja-client` when the REST resource is enabled.
- Read/update/delete client records via GET/PATCH/DELETE on the REST resource.
- Exclude `invoice_ninja.settings` from committed config exports to avoid leaking the token/password.
- Rotate the Invoice Ninja API token if a config export or database dump is exposed.
- Batch-onboard existing users into Invoice Ninja after granting them the sync permission.