<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# invoice_ninja — configuration

Form: `Drupal\invoice_ninja\Form\Settings` at `/admin/config/system/invoice_ninja`
(permission `administer invoice_ninja configuration`). Writes config object `invoice_ninja.settings`.

| Key | Field | Notes |
|-----|-------|-------|
| `invoice_ninja_url` | Invoice Ninja URL | Base URL of your Invoice Ninja instance (required). |
| `invoice_ninja_api_token` | API Token | Rendered as a password field but **stored in plaintext config** (required). |
| `synchronize_users` | Synchronize Users | Toggle; only users with the sync permission are synced. |
| `invoice_ninja_admin_password` | Admin User Password | Needed for some requests; shown only when Synchronize Users is on; **stored in plaintext config**. |

Set via Drush without the UI:
```
drush cset invoice_ninja.settings invoice_ninja_url 'https://ninja.example.com' -y
drush cset invoice_ninja.settings invoice_ninja_api_token 'TOKEN' -y
```
Because the token and admin password live in `invoice_ninja.settings`, they appear in `drush cex` output and the database. Keep this config out of committed/shared config exports, and rotate the token if it leaks. The synchronizer services (`SynchronizerBase::getInvoiceNinjaClient`) instantiate `new InvoiceNinja($token)` + `setUrl($url)` and reuse it; TLS verification is whatever the SDK defaults to (this module does not disable it).