<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration & admin — email_to_rss

Install: `composer require drupal/email_to_rss` (pulls `webklex/php-imap`), `drush en email_to_rss`.
Set the mailbox password in the environment (below) before syncing.

## Config object `email_to_rss.settings`

Single config object (schema: `config/schema/email_to_rss.schema.yml`; install defaults:
`config/install/email_to_rss.settings.yml`).

- `imap` mapping: `host` (string), `port` (int, default 993), `encryption` (string:
  `ssl`/`tls`/`starttls`/`''`; default `ssl`), `username` (string). **No password key** — it is
  read from the environment, not config.
- `feeds` sequence keyed by feed machine name, each: `label`, `folder` (e.g. `INBOX`),
  `feed_limit` (int, default `FeedDefaults::LIMIT` = 25), `token` (string, path segment),
  `enabled` (bool). Install ships a `default` feed (`INBOX`, limit 25, empty token).

`hook_install` (`email_to_rss.install`) fills any empty feed `token` with
`_email_to_rss_generate_token()` (`base64(random_bytes(24))`, URL-safe) on install.

## IMAP password (environment only)

`WebklexImapSource::config()` and `SettingsForm::passwordSet()` read `getenv('EMAIL_TO_RSS_IMAP_PASSWORD')`.
If host, username, or that env var is empty, `config()` returns NULL and the sync is skipped with a
warning. Set it in the host environment (DDEV: `ddev dotenv set .ddev/.env --email-to-rss-imap-password=…`
then `ddev restart`).

## Settings form — `Form\SettingsForm` (route `email_to_rss.settings`)

`/admin/config/services/email-to-rss`, `_permission: administer site configuration`; menu link in
`email_to_rss.links.menu.yml` under *Configuration → Web services*. `getFormId` = `email_to_rss_settings`;
`getEditableConfigNames` = `['email_to_rss.settings']`.

- **IMAP fieldset:** host, port, encryption (select), username, a read-only password status item
  (`✓ set in environment` / `— not set`), and a "not fully configured" note when incomplete.
- **Sync fieldset:** "Sync all now" submit (`::submitSyncNow`) → runs `EmailSync::run()` (guarded by
  `imapConfigured()`), reports inserted count.
- **Feeds table:** one row per feed — folder, label, `feed_limit`, item count
  (`EmailStorage::count()`), enabled status, a "Open" feed URL link
  (`Url::fromRoute('email_to_rss.feed', {feed_id, token})`, `rel=noopener noreferrer`), and an
  **Actions** select: `regenerate_token`, `enable`/`disable`, `delete_entries`, `delete`.
  "Add folder" (AJAX, `::submitAddFolder`) appends a blank `_new_N` row.
- **submitForm:** `delete`/`delete_entries` actions redirect to the confirm forms; otherwise it
  rebuilds `imap` (host/port/encryption/username) and `feeds` from the table. Each feed's machine
  name is `machineName(folder)` (lowercased, non-alphanumerics → `_`, ≤64 chars). Rows missing
  id/label/folder are dropped. A feed with an empty token, or with the `regenerate_token` action,
  gets a fresh `newToken()` (`base64(random_bytes(24))`, URL-safe).

## Delete confirm forms

- `Form\DeleteFeedForm` (route `email_to_rss.delete_feed`,
  `/admin/config/services/email-to-rss/feeds/{feed_id}/delete`): removes the feed's config entry and
  calls `EmailStorage::deleteAll($feedId)`. 404 if the feed id is unknown.
- `Form\DeleteFeedItemsForm` (route `email_to_rss.delete_feed_items`, `…/delete-items`): clears only
  that feed's mirrored rows.

Both require `administer site configuration` and are POST confirm forms.
