<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure — Cloudflare Email

**Settings:** `cloudflare_email.settings` → `/admin/config/system/cloudflare-email` (perm `administer cloudflare email`, restricted). Set the Cloudflare `account_id`, the `api_token_key` (a Key entity id), `sandbox_mode`, and default from address.

**Prerequisite — the token as a Key:** create a Key (e.g. env provider) holding the Cloudflare API token; `CloudflareEmailClient::resolveApiToken()` reads it via `@key.repository` so the secret never lives in module config.

**Selecting the backend:** set Cloudflare Email as the site Mail plugin (`Plugin/Mail/CloudflareEmail`), or use the `CloudflareApiTransport` Symfony Mailer transport / the `cloudflare_email_symfony_mailer_lite` submodule.

**Delivery:** `send()` POSTs to `https://api.cloudflare.com/client/v4/accounts/{id}/email/sending/send` (HTTPS, `Authorization: Bearer`, 10s timeout). `sandbox_mode` logs instead of sending. `CloudflareEmailQueueWorker` supports queued delivery. Errors raise `CloudflareEmailException` with the HTTP status as the code (transient vs permanent). Test with the Drush command in `Drush/Commands`.

**Analytics submodule:** `cloudflare_email_analytics` adds a report controller/route and its own permission.
