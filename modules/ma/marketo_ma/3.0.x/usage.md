<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Marketo MA integrates Adobe Marketo with Drupal: it injects the Munchkin tracking script to attach page views to known leads, and syncs lead data to Marketo's OAuth REST API from users, Webforms and Contact forms.

---

The base module does two things. First, `hook_page_attachments` (via `PageAttachment`) attaches the Munchkin JavaScript and a `drupalSettings.marketo_ma` payload — the Munchkin **Account ID**, the library URL (`//munchkin.marketo.net/munchkin.js`) and init params — on pages that pass the path and role visibility filters, so `js/marketo_ma.js` calls `Munchkin.init()`. Second, it configures an OAuth REST client (`neclimdul/marketo-rest`, base URL `https://{account_id}.mktorest.com`) that reads/writes leads, submits Marketo forms, and reads activities. A `tracking_method` setting chooses whether lead updates go client-side through Munchkin's `associateLead` action (signed server-side with `sha1(munchkin_private_key . email)`) or server-side through the REST API — the latter either synchronously or queued to the `marketo_ma_lead` QueueWorker for cron when `rest.batch_requests` is on. The **`Lead`** value object carries field data plus the optional `_mkto_trk` cookie and a Marketo program/form id. Credentials are resolved through a pluggable **Secrets** layer: `ImmutableConfigSecrets` (plain config, the default) or `EncryptionSecrets` (Encrypt module) — chosen automatically by `SecretsFactory`. Submodules add the capture points: **`marketo_ma_user`** syncs on user login/create/update and exposes per-user Lead and Activity tabs (permission `access all marketo lead data`); **`marketo_ma_webform`** provides a `marketo_ma` Webform handler mapping submission fields to Marketo fields (or a Forms 2.0 `formid`), optionally adding the lead to a list; **`marketo_ma_contact`** and **`marketo_ma_contact_block`** capture core Contact form submissions via third-party settings; **`marketo_ma_legacy_client`** swaps in the old, unmaintained SOAP/Guzzle-3 client. Because this ships identified personal data (email and mapped profile fields) to a third-party marketing platform and builds a named browsing profile, treat it as a data-processing activity: disclose it, gate it appropriately, and hold the REST client id/secret and Munchkin private key in an environment-backed Key or Encrypt secret rather than plain config.

---

- Add Munchkin page-view tracking to a site by Account ID.
- Restrict tracking to or from specific paths (default excludes `/admin`, `/node/add*`, `/user/*/*`).
- Restrict tracking to or from specific user roles.
- Associate a known lead with their Munchkin cookie client-side.
- Sync a Drupal user to a Marketo lead on login, creation or profile update.
- Map Drupal user profile fields to Marketo lead fields.
- Send a Webform submission to Marketo as a lead or a Forms 2.0 form post.
- Add a captured lead to a specific Marketo static list.
- Associate a Webform submission with the visitor's `_mkto_trk` cookie.
- Capture leads from core Contact form submissions (with contact_storage).
- Provide a Contact block that carries extra hidden Marketo-mapped values.
- Queue REST lead updates and flush them on cron (batch mode).
- Retrieve the Marketo lead-field catalogue for mapping.
- View a user's Marketo lead record inside Drupal.
- View a user's recent Marketo activity inside Drupal.
- Associate the current tracking cookie with a synced lead for cross-session stitching.
- Set a default program name per Webform handler.
- Alter outgoing lead data with `hook_marketo_ma_lead_alter()`.
- Store API secrets via the Encrypt or Key module instead of plain config.
- Choose between client-side Munchkin and server-side REST tracking per site.
- Support a demand-generation / lead-scoring pipeline fed from site behaviour.
- Track campaign landing pages and gated-content signups.
- Deprecated: swap in the legacy SOAP client for old integrations (unmaintained, PHP 8 incompatible).
