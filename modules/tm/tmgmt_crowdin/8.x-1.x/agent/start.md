<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# TMGMT Crowdin (tmgmt_crowdin) — agent index

A **TMGMT translator plugin** that submits Drupal content to the **Crowdin** localization platform
(Crowdin API v2) and imports completed translations back. Package `Translation Management`. Depends
on **`tmgmt`** and **`tmgmt_file`**. Core requirement `^10.1 || ^11`. PHP `>=7.2`. License
GPL-2.0-or-later. Version 8.x-1.14. No permissions.yml, no services.yml, no Drush.

- **The `crowdin` translator plugin, its API client, settings and Crowdin workflow** →
  [plugins/translator.md](plugins/translator.md)
- **The `webxml` tmgmt_file format plugin (export/import)** → [plugins/webxml.md](plugins/webxml.md)
- **The webhook endpoint and its route** → [api/webhook.md](api/webhook.md)
- **Config objects, schema and how the connection is stored** → [config/settings.md](config/settings.md)

## What it actually is (from source)

- One **TMGMT translator plugin**: `CrowdinTranslator` (id **`crowdin`**, label *"Crowdin"*), in
  `src/Plugin/tmgmt/Translator/CrowdinTranslator.php`, extending `TranslatorPluginBase` and
  implementing `ContinuousTranslatorInterface`. Its plugin UI is `CrowdinTranslatorUi`
  (`src/CrowdinTranslatorUi.php`). Logo `icons/crowdin.svg`.
- One **tmgmt_file format plugin**: `WebXML` (id **`webxml`**, label *"WEBXML"*), in
  `src/Plugin/tmgmt_file/Format/WebXML.php`, extending `\XMLWriter` and implementing
  `FormatInterface`. Exports job items to XML and imports Crowdin's returned XML.
- One **controller + route**: `CrowdinWebhookController::process()`
  (`src/Controller/CrowdinWebhookController.php`) on route `tmgmt_crowdin.file_webhook`
  (`/tmgmt_crowdin/process/file_webhook`), the endpoint Crowdin calls when a file is
  translated/approved.
- One **post-update hook**: `tmgmt_crowdin_post_update_delete_crowdin_settings()`
  (`tmgmt_crowdin.post_update.php`) migrates/removes legacy `crowdin.settings` config.

## Config & connection

- Connection settings live on the TMGMT **translator config entity** `tmgmt.translator.crowdin`:
  `personal_token` (Crowdin Personal Access Token), `project_id`, `domain` (Crowdin Enterprise
  organization domain, optional), and `xliff_cdata` (default TRUE). Schema
  `tmgmt.translator.settings.crowdin` in `config/schema/tmgmt_crowdin.schema.yml`.
- One additional config object `tmgmt_crowdin.settings` stores `webhook_id_by_project_id` (a
  serialized project-id → Crowdin webhook-id map). See [config/settings.md](config/settings.md).

## Mechanism at a glance

- Submit: `requestTranslation()` → `requestJobItemsTranslation()` exports each job item to WebXML,
  creates a `Drupal Connector` root directory + a per-job folder in Crowdin, uploads via the
  storages/files endpoints, records a `RemoteMapping`, and registers a webhook.
- Retrieve: `fetchTranslations()` (manual, from checkout UI) or the webhook controller
  (`file.translated` / `file.approved`) → `updateTranslation()` → `importTranslation()` pulls the
  built file from Crowdin, `WebXML::validateImport()` re-checks job-id/language, then
  `addTranslatedData()`.
- All HTTP is Guzzle against `https://api.crowdin.com/api/v2/` (or `<domain>.api.crowdin.com/...`
  for Enterprise), authenticated with `Authorization: Bearer <personal_token>`.
