<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Invoice Ninja (invoice_ninja) — agent index

**Syncs Drupal users, clients, VAT rates and invoices to an Invoice Ninja instance via its PHP SDK.**

- **Version:** 1.0.x (1.0.0-beta8)
- **Core:** ^10 || ^11 || ^12
- **Requires** the `invoiceninja/sdk` Composer package (`InvoiceNinja\Sdk\InvoiceNinja`).
- **Config route:** `invoice_ninja.settings` → `/admin/config/system/invoice_ninja` (perm `administer invoice_ninja configuration`).
- **Permissions:** `administer invoice_ninja configuration` (restricted), `administer invoice_ninja`, `access invoice_ninja`.
- **Services:** `user.synchronizer`, `client.synchronizer`, `vat.synchronizer`, `invoice.synchronizer` (all read `invoice_ninja.settings`, keep id maps in `@keyvalue`).
- **Actions:** `SyncClient`, `SyncInvoice`, `SyncVat`. **ECA condition:** `SyncStatus`. **Drush:** `invoice_ninja:synchronize_users` (alias `insu`).
- **REST:** `invoiceninja_client` resource at `/api/invoiceninja-client/{id}` (standard REST plugin; off until enabled + permissioned).

**Security:** admin config route is permission-gated. Note: API token and admin-user password are stored in plaintext in `invoice_ninja.settings` config (no Key/secrets integration) — see Settings.php:44-71 / submitForm. TLS is SDK-default (not disabled here). No unverified callback in module code.

See [configure/settings.md](configure/settings.md) and [drush/commands.md](drush/commands.md).