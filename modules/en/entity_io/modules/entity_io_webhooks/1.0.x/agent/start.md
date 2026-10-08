<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity IO Webhooks (entity_io_webhooks) — agent index

Submodule of **Entity IO**. Sends an entity's JSON export to HTTP / email / FTP on entity events.
Depends on `system`, `entity_io`, `smtp`. Core `^9 || ^10 || ^11`. `configure` route
`entity_io_webhooks.settings`. No permissions.yml (admin uses `administer site configuration`);
no config schema.

## Mechanism (from source)

- **Triggers** (`entity_io_webhooks.module`): `hook_entity_insert/update/delete` call
  `EntityIoWebHooks::trigger($entity, $event)` for content entities, unless
  `state('entity_io.skip_webhooks')` is set (Entity IO sets this during import). Content-moderation
  states are resolved to the real content entity and encoded into the event name
  (e.g. `update__draft_published`). `hook_mail` (`entity_notify`) builds an HTML mail with
  attachments for the SMTP module.
- **`EntityIoWebHooks`** (`src/EntityIoWebHooks.php`) — dispatches to the three delivery services.
- **`WebhooksManager`** (`entity_io_webhooks.manager`, args `@config.factory`, logger, `@http_client`,
  `@datetime.time`): reads `entity_io_webhooks.settings.entities.<type>.<bundle>`, checks the event is
  enabled, parses `Key: Value` headers (global `default_headers` + per-bundle), and POSTs a
  `{entity_type, bundle, id, event, timestamp, data}` payload to each configured URL with Guzzle
  (10s timeout).
- **`EntityIoMailSender`** (`entity_io_webhooks.mail`) — sends the export as a mail attachment via
  `plugin.manager.mail` / SMTP.
- **`FtpUploader`** (`entity_io_webhooks.ftp`) — uploads the export file over FTP (`ftp_connect`
  port 21, `ftp_put` FTP_BINARY) using the per-bundle host/user/pass/path.

## Config & forms

- **`entity_io_webhooks.settings`**: `default_events`, `default_headers`, and
  `entities.<type>.<bundle>` = `{events, webhooks:{urls, headers}, ftp:{ftp_host, ftp_user,
  ftp_pass, ftp_path}, mail:{…}}`.
- `WebhooksSettingsForm` (route `entity_io_webhooks.settings`) — global defaults.
  `EntityWebhookBundleForm` — per-bundle overrides on the entity-type pages.
